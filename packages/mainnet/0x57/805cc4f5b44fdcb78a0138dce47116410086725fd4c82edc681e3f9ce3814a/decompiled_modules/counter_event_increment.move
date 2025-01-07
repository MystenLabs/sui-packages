module 0x57805cc4f5b44fdcb78a0138dce47116410086725fd4c82edc681e3f9ce3814a::counter_event_increment {
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

