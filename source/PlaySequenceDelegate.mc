using Toybox.WatchUi as Ui;
using Toybox.System;

class PlaySequenceDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

	function onKey(k) {
	
		//if user hits escape button while the sequence is being played,
		//exit game and return to start screen
		if (k.getKey() == Ui.KEY_ESC) {
			sequenceTimer.stop();
			Ui.pushView(new SimonGameView(), new SimonGameDelegate(), Ui.SLIDE_IMMEDIATE);
		}
		
		return true;
	}
//
//    function onMenuItem(item) {
//    }

}