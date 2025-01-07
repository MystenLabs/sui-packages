module 0x406d2cf70ee18c4ff212b5360f7614196e274925ad25006f4e6b9f201bebd96a::clock {
    struct TimeEvent has copy, drop, store {
        timestamp_ms: u64,
    }

    entry fun access(arg0: &0x2::clock::Clock) {
        let v0 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v0);
        let v1 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

