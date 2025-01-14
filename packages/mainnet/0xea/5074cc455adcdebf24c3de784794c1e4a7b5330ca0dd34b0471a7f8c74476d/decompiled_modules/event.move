module 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::event {
    struct Event<T0: copy + drop> has copy, drop {
        event: T0,
    }

    public(friend) fun emit<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{event: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

