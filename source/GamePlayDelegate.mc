using Toybox.WatchUi as Ui;
using Toybox.System;

//Emilia
class GamePlayDelegate extends Ui.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }
    
    //           0=>green      1=>red      2=>yellow    3=>blue
    var keys = [ Ui.KEY_UP, Ui.KEY_ENTER, Ui.KEY_DOWN, Ui.KEY_ESC];

	function onKey(k) {
		//user hit a key so the timer stops,
		//then we check if it's the right key or not
		sequenceTimer.stop();
	
		//if the user hits the button that the sequence expected,
		//display color, increment step, and create a new GamePlayView
		if (k.getKey() == keys[seq[step]]){
			gamePlayColorIndex = seq[step];
			WatchUi.requestUpdate();	
			step++;
			
			//when step reaches the end of the list, 
 			//reset step to zero and stop timer, then transition to gameplay      
			if (step >= seq.size()) {
				step = 0;
				Ui.pushView(new PlaySequenceView(), new PlaySequenceDelegate(), Ui.SLIDE_IMMEDIATE);
    		}
    		else {
    			Ui.pushView(new GamePlayView(), new GamePlayDelegate(), Ui.SLIDE_IMMEDIATE);
    		}
			
			
		}
		//if the user hits a button that doesn't match what the sequence is expecting,
		//game over, return to start screen
		else {
			Ui.pushView(new SimonGameView(), new SimonGameDelegate(), Ui.SLIDE_IMMEDIATE);
		}
		
	}

    function onMenuItem(item) {
    }

}