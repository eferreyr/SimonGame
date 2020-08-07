using Toybox.WatchUi as Ui;

class SimonGameDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function onKey (k) {
    	step = 0;
        	
       	Ui.pushView(new PlaySequenceView(), new PlaySequenceDelegate(), Ui.SLIDE_IMMEDIATE);
               
        return true;
    }

    function onMenu() {
        return true;
    }

}