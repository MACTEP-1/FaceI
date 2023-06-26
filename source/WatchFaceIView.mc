import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;
import Toybox.WatchUi;

class WatchFaceIView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Get and show the current time
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        var view = View.findDrawableById("TimeLabel") as Text;
        view.setText(timeString);

        // Battery level
        var sysStats = System.getSystemStats();
        var batLife = sysStats.battery;
        var batLifeInDays = sysStats.batteryInDays;
        var batView = View.findDrawableById("BatteryDisplay") as Text;
        var batString = Lang.format("Battery is at $1$%,\ngood for $2$ days", [batLife.format("%.0d"), batLifeInDays.format("%.0d")]);
        batView.setText(batString);

        // Date and day
        var date = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        //var dayOfWeek = date.day_of_week;
        var dayOfWeekView = View.findDrawableById("DayOfTheWeek") as Text;
        dayOfWeekView.setText(["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"][date.day_of_week-1]);
        //dayOfWeekView.setText("Tuesday");

        var dateLong = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var dateView = View.findDrawableById("DateDisplay") as Text;
        dateView.setText(dateLong.month + " " + date.day + " " + date.year.format("%4d"));

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
