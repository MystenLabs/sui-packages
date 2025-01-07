module 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch {
    struct Epoch has store, key {
        id: 0x2::object::UID,
        value: u64,
        state: u8,
        timestamp: u64,
        expansion_duration: u64,
        contraction_duration: u64,
    }

    public fun epoch(arg0: &Epoch) : u64 {
        arg0.value
    }

    public fun check_epoch(arg0: &Epoch, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) >= next_epoch_timestamp(arg0), 1);
    }

    public fun contraction_duration(arg0: &Epoch) : u64 {
        arg0.contraction_duration
    }

    public(friend) fun create(arg0: u64, arg1: u64, arg2: u64, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) < arg0 && arg1 > 0 && arg2 > 0, 0);
        let v0 = Epoch{
            id                   : 0x2::object::new(arg5),
            value                : 0,
            state                : 0,
            timestamp            : arg0,
            expansion_duration   : arg1,
            contraction_duration : arg2,
        };
        let v1 = &mut v0;
        set_state(v1, arg3);
        0x2::transfer::share_object<Epoch>(v0);
    }

    public fun expansion_duration(arg0: &Epoch) : u64 {
        arg0.expansion_duration
    }

    public(friend) fun next(arg0: &mut Epoch) {
        let v0 = if (0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::state::is_expansion(arg0.state)) {
            arg0.expansion_duration
        } else {
            arg0.contraction_duration
        };
        arg0.value = arg0.value + 1;
        arg0.timestamp = arg0.timestamp + v0;
    }

    public fun next_epoch_timestamp(arg0: &Epoch) : u64 {
        let v0 = if (0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::state::is_expansion(arg0.state)) {
            arg0.expansion_duration
        } else {
            arg0.contraction_duration
        };
        arg0.timestamp + v0
    }

    public(friend) fun set_contraction_duration(arg0: &mut Epoch, arg1: u64) {
        arg0.contraction_duration = arg1;
    }

    public(friend) fun set_epoch(arg0: &mut Epoch, arg1: u64) {
        arg0.value = arg1;
    }

    public(friend) fun set_expansion_duration(arg0: &mut Epoch, arg1: u64) {
        arg0.expansion_duration = arg1;
    }

    public(friend) fun set_state(arg0: &mut Epoch, arg1: u8) {
        0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::state::assert_state(arg1);
        arg0.state = arg1;
    }

    public fun state(arg0: &Epoch) : u8 {
        arg0.state
    }

    public fun timestamp(arg0: &Epoch) : u64 {
        arg0.timestamp
    }

    // decompiled from Move bytecode v6
}

