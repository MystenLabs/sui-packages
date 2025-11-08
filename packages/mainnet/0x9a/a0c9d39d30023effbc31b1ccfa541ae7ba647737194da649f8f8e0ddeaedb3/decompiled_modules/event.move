module 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::event {
    struct Event<T0: copy + drop> has copy, drop {
        event: T0,
    }

    public(friend) fun emit<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{event: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

