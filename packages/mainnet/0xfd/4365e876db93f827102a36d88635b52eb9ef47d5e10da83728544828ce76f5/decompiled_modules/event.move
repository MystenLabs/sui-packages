module 0xfd4365e876db93f827102a36d88635b52eb9ef47d5e10da83728544828ce76f5::event {
    struct Event<T0: copy + drop> has copy, drop {
        event: T0,
    }

    public(friend) fun emit<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{event: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

