module 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_event_wrapper {
    struct BlizzardEvent<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    public(friend) fun emit_event<T0: copy + drop>(arg0: T0) {
        let v0 = BlizzardEvent<T0>{pos0: arg0};
        0x2::event::emit<BlizzardEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

