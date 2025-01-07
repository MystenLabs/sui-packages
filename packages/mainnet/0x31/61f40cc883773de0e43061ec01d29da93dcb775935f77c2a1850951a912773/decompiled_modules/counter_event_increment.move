module 0x3161f40cc883773de0e43061ec01d29da93dcb775935f77c2a1850951a912773::counter_event_increment {
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

