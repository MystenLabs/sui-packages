module 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events {
    struct Event<T0: copy + drop> has copy, drop {
        event: T0,
    }

    public(friend) fun emit_event<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{event: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    // decompiled from Move bytecode v7
}

