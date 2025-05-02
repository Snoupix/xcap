use std::fs;

use xcap::Monitor;

fn normalized(filename: String) -> String {
    filename.replace(['|', '\\', ':', '/'], "")
}

fn main() {
    let mut monitors = Monitor::all().expect("Failed to get Monitors").into_iter();

    if !monitors.any(|monitor| monitor.is_primary().is_ok_and(|b| b)) {
        eprintln!("No primary monitor found");
        return;
    }

    let monitor = monitors
        .find(|monitor| monitor.is_primary().unwrap())
        .unwrap();

    let _ = fs::create_dir("x");

    let image = monitor.capture_image().unwrap();

    image
        .save(format!(
            "x/monitor-{}.png",
            normalized(monitor.name().unwrap())
        ))
        .unwrap();
}
