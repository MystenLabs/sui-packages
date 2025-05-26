module 0x5fe5dca28c979f8e4cb08fc77f32e80093c95e31f11d2a4b56bd7f2e656c2846::clock {
    struct TimeEvent has copy, drop, store {
        timestamp_ms: u64,
    }

    entry fun access(arg0: &0x2::clock::Clock) {
        let v0 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

