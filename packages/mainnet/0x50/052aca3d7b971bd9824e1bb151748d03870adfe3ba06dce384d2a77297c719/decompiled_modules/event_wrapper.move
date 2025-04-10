module 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::event_wrapper {
    struct InterestStableSwapEvent<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    public(friend) fun emit_event<T0: copy + drop>(arg0: T0) {
        let v0 = InterestStableSwapEvent<T0>{pos0: arg0};
        0x2::event::emit<InterestStableSwapEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

