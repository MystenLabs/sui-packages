module 0xf1a24c6b1947f47c5811a0e2c4adeeafa5fc9383ebbb93eea91bb5eadc79ed4e::event_wrapper {
    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    public(friend) fun emit_event<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{pos0: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

