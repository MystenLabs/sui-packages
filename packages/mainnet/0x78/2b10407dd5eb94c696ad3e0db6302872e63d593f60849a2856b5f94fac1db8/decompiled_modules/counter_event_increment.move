module 0x782b10407dd5eb94c696ad3e0db6302872e63d593f60849a2856b5f94fac1db8::counter_event_increment {
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

