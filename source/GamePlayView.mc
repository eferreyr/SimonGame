using Toybox.WatchUi as Ui;
using Toybox.Graphics;
using Toybox.Application as App;
using Toybox.Attention;
using Toybox.Math;
using Toybox.System;

var gamePlayColorIndex;
var keyPressed;

class GamePlayView extends Ui.View {
	

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    	gamePlayColorIndex = -1; //black
    	keyPressed = false;
		
		//start sequenceTimer which gives player 3 seconds to press the correct button
		//if no button is pressed within this time, player loses and endGameCallback is called
		sequenceTimer.start(method(:endGameCallback), 3000, false);
    }
	
	//end game and return to start screen
	function endGameCallback() {
        Ui.pushView(new SimonGameView(), new SimonGameDelegate(), Ui.SLIDE_IMMEDIATE); //go to start screen
    }
    
    function resetColorCallback() {
    	//can't pass dc into this function which is needed to show color
    	//so do nothing here and show color in onUpdate after
    }
    
    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
    	//play(seq[step]); //play sound
    	
    	showColor(dc, gamePlayColorIndex); //show color
		
    	if(keyPressed) {
    		keyPressed = false;
    		sequenceTimer.start(method(:endGameCallback), 3000, false);
    	}
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}


