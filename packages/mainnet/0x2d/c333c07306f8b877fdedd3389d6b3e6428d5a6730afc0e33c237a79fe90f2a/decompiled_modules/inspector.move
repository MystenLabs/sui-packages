module 0x2dc333c07306f8b877fdedd3389d6b3e6428d5a6730afc0e33c237a79fe90f2a::inspector {
    struct Event<T0: copy + drop> has copy, drop {
        val: T0,
    }

    public fun emit<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{val: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

