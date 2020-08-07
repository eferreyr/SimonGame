using Toybox.WatchUi as Ui;
using Toybox.Graphics;
using Toybox.Application as App;
using Toybox.Timer;
using Toybox.Attention;
using Toybox.Math;

var colors = [Graphics.COLOR_DK_GREEN, Graphics.COLOR_DK_RED, Graphics.COLOR_YELLOW, Graphics.COLOR_DK_BLUE];
var tones = [Attention.TONE_ALERT_HI, Attention.TONE_ALERT_LO, Attention.TONE_INTERVAL_ALERT, Attention.TONE_ALARM];

function showColor(dc, colorIndex) {
	//set foreground to transparent and background to black
	dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_BLACK);
	dc.clear(); //clear away anything drawn on the screen
	
	//set foreground to black if colorIndex < 0 and the color at index specified in colors array
	//keep background black and draw a circle in corresponding corner
	dc.setColor( colorIndex < 0 ? Graphics.COLOR_BLACK : colors[colorIndex] , Graphics.COLOR_BLACK);
	dc.fillCircle(getX(colorIndex), getY(colorIndex), screenWidth * .75);
}

//Button 0 has coordinates (0,0), Button 1 has corrdinates (0,1), and so on
//  __________
//0>|0,0 |0,1|<1
//  |____|___|
//2>|1,0 |1,1|<3
//  |____|___|

//if button number is 0 or 2 (divisible by 2), then X is 0
//otherwise, buttons 1 and 3 will start halfway across the screen
function getX( color ) {
	return (color % 2) == 0 ? 0 : screenWidth;
}

//if button number is 0 or 1 (less than 2), then Y is 0
//otherwise, buttons 2 and 3 will start halfway down the screen
function getY( color ) {
	return color < 2 ? 0 : screenHeight;
}

//tone is a number between 0 and 3 that represents a value in tones[] at given index
function play( tone ) {		
	if ( Attention has :playTone ) {
		Attention.playTone( tones[tone] );
	} 
}


class PlaySequenceView extends Ui.View {

	const ACCELERATION_FACTOR = .9; //with every iteration, sequence will play 10% faster
	const BLINK_FACTOR = .8; //time alotted to flash black before flashing next color

	var currentColorIndex; //index of the color value in colors array currently needed

	function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
		//add a number between 0 and 3 to the end of seq
		addToSequence();
		
		//increment iteration
		iteration++;
		
		currentColorIndex = seq[step];
		
		//timer for drawing each color in sequence
		//after every specified wait period, draw next color in sequence
		sequenceTimer.start( method(:drawColorCallback), waitTime(), true );
		
    }

    function onShow() {
    }
    
    // Update the view
    function onUpdate(dc) {
 		//when step reaches the end of the list, 
 		//reset step to zero and stop timer, then transition to gameplay      
		if (step >= seq.size()) {
			step = 0;
    		sequenceTimer.stop();
			Ui.pushView(new GamePlayView(), new GamePlayDelegate(), Ui.SLIDE_IMMEDIATE);
    	}
		
		//play tone at index given by value in seq[step]
		//play(seq[step]);
		
		//draw color
		showColor(dc, currentColorIndex);
		
		//timer that leaves color up for 80% of sequenceTimer period
		//then paints screen black again
		//this is for distinguishing that two of the same colors in a row
		//are, in fact, two different elements in the sequence
		clearingTimer.start(method(:clearColorCallback), waitTime() * BLINK_FACTOR, false);
    }
	
    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

	//generates a random integer whose modulus of 4 is then caluculated 
	//the resulting number will be between 0 and 3
	//these four possible numbers each represent a button in the simon game 
	//this number is then added to the end of a list "seq" 
	//that represents the sequence the buttons should be pushed in
    function addToSequence() {
    	seq.add(Math.rand() % 4);
    }
    
    function drawColorCallback() {
        step++; //increment step
        
        //while there is another element in seq, set currentColorIndex to next value in seq
        if (step < seq.size()) {
        	currentColorIndex = seq[step];
        }
        
        //update color
        Ui.requestUpdate();
    }
    
    //update color to black
    function clearColorCallback() {
        currentColorIndex = -1;  // black
        Ui.requestUpdate();
    }

	function waitTime() {
		return Math.pow(ACCELERATION_FACTOR, iteration) * 1000;
	}
	
	
}

