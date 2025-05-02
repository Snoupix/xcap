use std::fs;

use xcap::Monitor;

fn normalized(filename: String) -> String {
    filename.replace(['|', '\\', ':', '/'], "")
}

fn main() {
    let monitors = Monitor::all().unwrap();

    let _ = fs::create_dir("x");

    for monitor in monitors {
        let image = monitor.capture_image().unwrap();

        image
            .save(format!(
                "x/monitor-{}.png",
                normalized(monitor.name().unwrap())
            ))
            .unwrap();
    }
}
