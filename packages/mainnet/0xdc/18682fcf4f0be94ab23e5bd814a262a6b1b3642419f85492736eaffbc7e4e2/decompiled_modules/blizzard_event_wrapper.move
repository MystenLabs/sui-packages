module 0xdc18682fcf4f0be94ab23e5bd814a262a6b1b3642419f85492736eaffbc7e4e2::blizzard_event_wrapper {
    struct BlizzardEvent<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    public(friend) fun emit_event<T0: copy + drop>(arg0: T0) {
        let v0 = BlizzardEvent<T0>{pos0: arg0};
        0x2::event::emit<BlizzardEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

