module 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event {
    struct EventWrapper<T0> has copy, drop {
        event: T0,
    }

    public fun emit<T0: copy + drop>(arg0: T0) {
        let v0 = EventWrapper<T0>{event: arg0};
        0x2::event::emit<EventWrapper<T0>>(v0);
    }

    public fun inner<T0: copy + drop>(arg0: &EventWrapper<T0>) : &T0 {
        &arg0.event
    }

    // decompiled from Move bytecode v7
}

