using Toybox.WatchUi as Ui;
using Toybox.Graphics;
using Toybox.Application as App;
using Toybox.Attention;
using Toybox.Math;
using Toybox.System;

var gamePlayColorIndex;

//Emilia
class GamePlayView extends Ui.View {
	var deeCee;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    	gamePlayColorIndex = -1; //black
		
		sequenceTimer.start(method(:endGamecallback), 3000, false);
    }
	
	//end game and return to start screen
	function endGamecallback() {
		sequenceTimer.stop();
        Ui.pushView(new SimonGameView(), new SimonGameDelegate(), Ui.SLIDE_IMMEDIATE);
    }
    
    function resetColorCallback() {
    	
    	showColor(deeCee, gamePlayColorIndex);
    }
    
    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
    	play(seq[step]);
    	
    	showColor(dc, gamePlayColorIndex);
		
		gamePlayColorIndex = -1;
		deeCee = dc;
		
		clearingTimer.start(method(:resetColorCallback), 500, false);
		
		
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}


