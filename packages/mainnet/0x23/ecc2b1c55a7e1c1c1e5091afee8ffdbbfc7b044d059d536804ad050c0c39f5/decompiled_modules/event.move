module 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::event {
    struct Event<T0: copy + drop> has copy, drop {
        event: T0,
    }

    public(friend) fun emit<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{event: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

