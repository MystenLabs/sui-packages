module 0x7065c17a097025d2d3b60602c735b9b4e3e1b1e4ca81661be3f5e7097d3fde41::counter_event_increment {
    struct IncrementEvent has copy, drop {
        value: u32,
    }

    public fun emit(arg0: u32) {
        let v0 = IncrementEvent{value: arg0};
        0x2::event::emit<IncrementEvent>(v0);
    }

    public fun new(arg0: u32) : IncrementEvent {
        IncrementEvent{value: arg0}
    }

    // decompiled from Move bytecode v6
}

