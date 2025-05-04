use std::fs;

use xcap::Monitor;

fn normalized(filename: String) -> String {
    filename.replace(['|', '\\', ':', '/'], "")
}

fn main() {
    let monitors = Monitor::all().expect("Failed to get Monitors");

    if !monitors
        .iter()
        .any(|monitor| monitor.is_primary().is_ok_and(|b| b))
    {
        eprintln!("No primary monitor found");

        std::process::exit(1);
    }

    let monitor = monitors
        .into_iter()
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
