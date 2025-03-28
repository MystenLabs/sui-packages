module 0xc694b2f18981198059c354fe8897f3767c591da434edc9e8f4c700e09886a181::blizzard_event_wrapper {
    struct BlizzardEvent<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    public(friend) fun emit_event<T0: copy + drop>(arg0: T0) {
        let v0 = BlizzardEvent<T0>{pos0: arg0};
        0x2::event::emit<BlizzardEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

