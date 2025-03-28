module 0x31b24ac69ea0c8cca085ddc3d946900c8c2070dad3d84a7de0a4a88923249ad7::blizzard_event_wrapper {
    struct BlizzardEvent<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    public(friend) fun emit_event<T0: copy + drop>(arg0: T0) {
        let v0 = BlizzardEvent<T0>{pos0: arg0};
        0x2::event::emit<BlizzardEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

