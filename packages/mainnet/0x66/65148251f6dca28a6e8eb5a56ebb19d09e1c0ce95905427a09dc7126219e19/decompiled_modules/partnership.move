module 0x6665148251f6dca28a6e8eb5a56ebb19d09e1c0ce95905427a09dc7126219e19::partnership {
    struct Partnership<phantom T0> has key {
        id: 0x2::object::UID,
        fee_rate: u128,
        requires_kiosk: bool,
    }

    public fun new<T0>(arg0: &0x6665148251f6dca28a6e8eb5a56ebb19d09e1c0ce95905427a09dc7126219e19::access_control::AccessControl, arg1: &0x6665148251f6dca28a6e8eb5a56ebb19d09e1c0ce95905427a09dc7126219e19::access_control::Admin, arg2: u128, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : Partnership<T0> {
        0x6665148251f6dca28a6e8eb5a56ebb19d09e1c0ce95905427a09dc7126219e19::admin::assert_is_authorized(arg0, arg1);
        assert!(0x6665148251f6dca28a6e8eb5a56ebb19d09e1c0ce95905427a09dc7126219e19::constants::max_fee_rate() >= arg2, 9223372255898107905);
        Partnership<T0>{
            id             : 0x2::object::new(arg4),
            fee_rate       : arg2,
            requires_kiosk : arg3,
        }
    }

    public fun destroy<T0>(arg0: Partnership<T0>, arg1: &0x6665148251f6dca28a6e8eb5a56ebb19d09e1c0ce95905427a09dc7126219e19::access_control::AccessControl, arg2: &0x6665148251f6dca28a6e8eb5a56ebb19d09e1c0ce95905427a09dc7126219e19::access_control::Admin) {
        0x6665148251f6dca28a6e8eb5a56ebb19d09e1c0ce95905427a09dc7126219e19::admin::assert_is_authorized(arg1, arg2);
        let Partnership {
            id             : v0,
            fee_rate       : _,
            requires_kiosk : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun fee_rate<T0>(arg0: &Partnership<T0>) : u128 {
        arg0.fee_rate
    }

    public(friend) fun requires_kiosk<T0>(arg0: &Partnership<T0>) : bool {
        arg0.requires_kiosk
    }

    public fun share<T0>(arg0: Partnership<T0>) {
        0x2::transfer::share_object<Partnership<T0>>(arg0);
    }

    public fun update<T0>(arg0: &mut Partnership<T0>, arg1: &0x6665148251f6dca28a6e8eb5a56ebb19d09e1c0ce95905427a09dc7126219e19::access_control::AccessControl, arg2: &0x6665148251f6dca28a6e8eb5a56ebb19d09e1c0ce95905427a09dc7126219e19::access_control::Admin, arg3: u128) {
        0x6665148251f6dca28a6e8eb5a56ebb19d09e1c0ce95905427a09dc7126219e19::admin::assert_is_authorized(arg1, arg2);
        assert!(0x6665148251f6dca28a6e8eb5a56ebb19d09e1c0ce95905427a09dc7126219e19::constants::max_fee_rate() >= arg3, 9223372324617584641);
        arg0.fee_rate = arg3;
        0x6665148251f6dca28a6e8eb5a56ebb19d09e1c0ce95905427a09dc7126219e19::events::emit_update_partnership<T0>(arg0.requires_kiosk, arg0.fee_rate);
    }

    // decompiled from Move bytecode v6
}

