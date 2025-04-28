module 0x4e0afac3271e843b0a798daa676fff5a9cb1c82c1a17dc082ed54981145dfafb::clock {
    struct TimeEvent has copy, drop, store {
        timestamp_ms: u64,
    }

    entry fun access(arg0: &0x2::clock::Clock) {
        let v0 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

