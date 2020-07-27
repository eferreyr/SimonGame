using Toybox.WatchUi;

class SimonGameView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
		screenHeight = dc.getHeight();
		screenWidth = dc.getWidth();
		
		clearingTimer = new Timer.Timer();
    	sequenceTimer = new Timer.Timer();
    	iteration = 0;
		step = 0;
		seq = [];
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    	System.println("SimonGameView onShow ");
    	View.onShow();
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}


