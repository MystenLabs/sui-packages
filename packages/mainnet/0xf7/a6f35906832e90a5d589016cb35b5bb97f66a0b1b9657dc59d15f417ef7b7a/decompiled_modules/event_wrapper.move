module 0xf7a6f35906832e90a5d589016cb35b5bb97f66a0b1b9657dc59d15f417ef7b7a::event_wrapper {
    struct InterestStableSwapEvent<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    public(friend) fun emit_event<T0: copy + drop>(arg0: T0) {
        let v0 = InterestStableSwapEvent<T0>{pos0: arg0};
        0x2::event::emit<InterestStableSwapEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

