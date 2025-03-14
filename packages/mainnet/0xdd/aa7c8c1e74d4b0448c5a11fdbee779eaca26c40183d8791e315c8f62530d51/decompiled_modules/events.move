module 0xddaa7c8c1e74d4b0448c5a11fdbee779eaca26c40183d8791e315c8f62530d51::events {
    struct Event<T0: copy + drop> has copy, drop {
        event: T0,
    }

    public(friend) fun emit_event<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{event: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

