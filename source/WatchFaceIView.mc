import Toybox.Activity;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;
import Toybox.WatchUi;

class WatchFaceIView extends WatchUi.WatchFace {

    //private var _backdrop as Drawable;

    function initialize() {
        WatchFace.initialize();
        //_backdrop = new $.Rez.Drawables.backdrop();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
        /* dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_RED);
        dc.fillCircle(dc.getWidth(), dc.getHeight(), 80);
        dc.fillRectangle(100, 100, 100, 100); */
        
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        /*dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_RED);
        dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());
        System.println("w: " + dc.getWidth() + " h: " + dc.getHeight());*/
        //var bg = View.findDrawableById("Background");
        //bg.setColor(Graphics.COLOR_RED);

        dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_RED);
        dc.clear();

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
        var batString = Lang.format("Заряд на $1$%, $2$ суток", [batLife.format("%.0d"), batLifeInDays.format("%.0d")]);
        batView.setText(batString);

        // Date and day
        var date = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        //var dayOfWeek = date.day_of_week;
        var dayOfWeekView = View.findDrawableById("DayOfTheWeek") as Text;
        dayOfWeekView.setText(["Воскресенье","Понедельник","Вторник","Среда","Четверг","Пятница","Суббота"][date.day_of_week-1]);
        //dayOfWeekView.setText("Tuesday");

        var dateLong = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var dateView = View.findDrawableById("DateDisplay") as Text;
        dateView.setText(dateLong.month + " " + date.day + " " + date.year.format("%4d"));

        // HR
        var hr = Activity.getActivityInfo();
        var hrView = View.findDrawableById("HeartRateDisplay") as Text;
        hrView.setText(hr.currentHeartRate == null ? "" : hr.currentHeartRate + " ударов в минуту");

        // Steps
        var stepCnt = ActivityMonitor.getInfo();
        var stepView = View.findDrawableById("StepCountDisplay") as Text;
        stepView.setText(stepCnt.steps == null || stepCnt.steps == 0 ? "Двигаемся!" : stepCnt.steps + " шагов");

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
