module 0x2617ce867a891ebeca35c51e732fd6188e802ce370c3658b849ab7106dd5220b::timestamp {
    struct TimeEvent has copy, drop, store {
        timestamp: u64,
    }

    public fun emit_time_event(arg0: &0x2::clock::Clock) {
        let v0 = TimeEvent{timestamp: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

