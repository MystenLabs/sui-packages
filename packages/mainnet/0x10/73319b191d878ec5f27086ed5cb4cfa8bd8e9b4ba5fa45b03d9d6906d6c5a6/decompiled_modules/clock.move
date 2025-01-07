module 0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::clock {
    struct TimeEvent has copy, drop, store {
        timestamp_ms: u64,
    }

    public entry fun access(arg0: &0x2::clock::Clock) {
        let v0 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

