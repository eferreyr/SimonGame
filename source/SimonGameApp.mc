using Toybox.Application as App;
using Toybox.WatchUi;
using Toybox.Math;
using Toybox.Timer;

var sequenceTimer;
var clearingTimer;
var seq;
var step;
var iteration;
var wait;
var interval;
var maxStep; 
var screenHeight;
var screenWidth;
var endGame;

class SimonGameApp extends App.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    	
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new SimonGameView(), new SimonGameDelegate() ];
    }

}
