module 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_events {
    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    public(friend) fun emit_event<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{pos0: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    // decompiled from Move bytecode v7
}

