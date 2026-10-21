module 0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::blast_events {
    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    public(friend) fun emit_event<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{pos0: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    // decompiled from Move bytecode v7
}

