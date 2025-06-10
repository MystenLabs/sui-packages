module 0xd70f76763cf34d44e8df6dc77f3b47c380a9ea9be8bc745c8e58caf898da05e9::clock {
    struct TimeEvent has copy, drop, store {
        timestamp_ms: u64,
    }

    entry fun access(arg0: &0x2::clock::Clock) {
        let v0 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

