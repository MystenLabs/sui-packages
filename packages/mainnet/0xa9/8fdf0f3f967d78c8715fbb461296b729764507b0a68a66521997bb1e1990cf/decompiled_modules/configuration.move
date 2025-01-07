module 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration {
    struct Configuration<phantom T0> has store, key {
        id: 0x2::object::UID,
        min_bet_amounts: 0x2::table::Table<0x1::string::String, u64>,
        treasury_fee_bps: u64,
        price_feed_update_allowance: u64,
        buffer_ms: u64,
        interval_ms: u64,
    }

    public(friend) fun new<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Configuration<T0> {
        Configuration<T0>{
            id                          : 0x2::object::new(arg4),
            min_bet_amounts             : 0x2::table::new<0x1::string::String, u64>(arg4),
            treasury_fee_bps            : arg0,
            price_feed_update_allowance : arg1,
            buffer_ms                   : arg2,
            interval_ms                 : arg3,
        }
    }

    public fun buffer_ms<T0>(arg0: &Configuration<T0>) : u64 {
        arg0.buffer_ms
    }

    public fun interval_ms<T0>(arg0: &Configuration<T0>) : u64 {
        arg0.interval_ms
    }

    public fun min_bet_amount<T0>(arg0: &Configuration<T0>, arg1: 0x1::string::String) : u64 {
        *0x2::table::borrow<0x1::string::String, u64>(&arg0.min_bet_amounts, arg1)
    }

    public fun price_feed_update_allowance<T0>(arg0: &Configuration<T0>) : u64 {
        arg0.price_feed_update_allowance
    }

    public(friend) fun share<T0>(arg0: Configuration<T0>) {
        0x2::transfer::public_share_object<Configuration<T0>>(arg0);
    }

    public fun treasury_fee_bps<T0>(arg0: &Configuration<T0>) : u64 {
        arg0.treasury_fee_bps
    }

    public(friend) fun update<T0>(arg0: &mut Configuration<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        arg0.treasury_fee_bps = arg1;
        arg0.price_feed_update_allowance = arg2;
        arg0.buffer_ms = arg3;
        arg0.interval_ms = arg4;
    }

    public(friend) fun update_min_bet_amount<T0, T1>(arg0: &mut Configuration<T0>, arg1: u64) {
        let v0 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::utils::get_type<T1>();
        let v1 = &mut arg0.min_bet_amounts;
        if (0x2::table::contains<0x1::string::String, u64>(v1, v0)) {
            *0x2::table::borrow_mut<0x1::string::String, u64>(v1, v0) = arg1;
        } else {
            0x2::table::add<0x1::string::String, u64>(v1, v0, arg1);
        };
    }

    // decompiled from Move bytecode v6
}

