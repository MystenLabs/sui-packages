module 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::oracle {
    struct Oracle has store, key {
        id: 0x2::object::UID,
        last_price: u128,
        last_timestamp: u64,
        total_cumulative_price: u256,
        last_window_end_cumulative_price: u256,
        last_window_end: u64,
        last_window_twap: u128,
        twap_start_delay: u64,
        twap_cap_step: u64,
        market_start_time: 0x1::option::Option<u64>,
        twap_initialization_price: u128,
    }

    struct PriceEvent has copy, drop {
        last_price: u128,
    }

    public fun get_config(arg0: &Oracle) : (u64, u64) {
        (arg0.twap_start_delay, arg0.twap_cap_step)
    }

    public fun get_id(arg0: &Oracle) : &0x2::object::UID {
        &arg0.id
    }

    public fun get_last_price(arg0: &Oracle) : u128 {
        arg0.last_price
    }

    public fun get_last_timestamp(arg0: &Oracle) : u64 {
        arg0.last_timestamp
    }

    public fun get_market_start_time(arg0: &Oracle) : 0x1::option::Option<u64> {
        arg0.market_start_time
    }

    public fun get_total_cumulative_price(arg0: &Oracle) : u256 {
        arg0.total_cumulative_price
    }

    public(friend) fun get_twap(arg0: &Oracle, arg1: &0x2::clock::Clock) : u128 {
        assert!(0x1::option::is_some<u64>(&arg0.market_start_time), 14);
        let v0 = *0x1::option::borrow<u64>(&arg0.market_start_time);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(v1 == arg0.last_timestamp, 6);
        assert!(arg0.last_timestamp != 0, 0);
        assert!(v1 - v0 >= arg0.twap_start_delay, 1);
        assert!(v1 >= v0, 0);
        let v2 = v1 - v0 - arg0.twap_start_delay;
        assert!(v2 > 0, 2);
        ((arg0.total_cumulative_price / (v2 as u256)) as u128)
    }

    public fun get_twap_initialization_price(arg0: &Oracle) : u128 {
        arg0.twap_initialization_price
    }

    fun intra_window_accumulation(arg0: &mut Oracle, arg1: u128, arg2: u64, arg3: u64) {
        let v0 = (one_step_cap_price_change(arg0.last_window_twap, arg1, arg0.twap_cap_step) as u256);
        arg0.total_cumulative_price = arg0.total_cumulative_price + v0 * (arg2 as u256);
        arg0.last_timestamp = arg3;
        arg0.last_price = (v0 as u128);
        let v1 = PriceEvent{last_price: arg0.last_price};
        0x2::event::emit<PriceEvent>(v1);
        if (arg3 - arg0.last_window_end == 60000) {
            arg0.last_window_end = arg3;
            arg0.last_window_twap = (((arg0.total_cumulative_price - arg0.last_window_end_cumulative_price) / (60000 as u256)) as u128);
            arg0.last_window_end_cumulative_price = arg0.total_cumulative_price;
        };
    }

    fun multi_full_window_accumulation(arg0: &mut Oracle, arg1: u128, arg2: u64, arg3: u64) {
        let v0 = if (arg1 > arg0.last_window_twap) {
            arg1 - arg0.last_window_twap
        } else {
            arg0.last_window_twap - arg1
        };
        let v1 = if (v0 == 0) {
            0
        } else {
            (v0 - 1) / (arg0.twap_cap_step as u128) + 1
        };
        let v2 = if (v1 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v1 as u64)
        };
        let v3 = if (v2 == 0) {
            0
        } else {
            v2 - 1
        };
        let v4 = 0x1::u64::min(arg2, v3);
        let v5 = if (v4 == 0) {
            0
        } else {
            let v6 = (v4 as u128);
            let v7 = if (v6 % 2 == 0) {
                v6 / 2 * (v6 + 1)
            } else {
                (v6 + 1) / 2 * v6
            };
            let v8 = if (v7 > 0) {
                if ((arg0.twap_cap_step as u128) > 0) {
                    (arg0.twap_cap_step as u128) > 340282366920938463463374607431768211455 / v7
                } else {
                    false
                }
            } else {
                false
            };
            if (v8) {
                abort 7
            };
            (arg0.twap_cap_step as u128) * v7
        };
        let v9 = arg2 - v4;
        let v10 = if (v9 == 0) {
            0
        } else {
            let v11 = (v9 as u128);
            let v12 = if (v11 > 0) {
                if (v0 > 0) {
                    v0 > 340282366920938463463374607431768211455 / v11
                } else {
                    false
                }
            } else {
                false
            };
            if (v12) {
                abort 8
            };
            v0 * v11
        };
        if (v5 > 340282366920938463463374607431768211455 - v10) {
            abort 9
        };
        let v13 = v5 + v10;
        let v14 = (arg2 as u128);
        let v15 = if (v14 > 0) {
            if (arg0.last_window_twap > 0) {
                arg0.last_window_twap > 340282366920938463463374607431768211455 / v14
            } else {
                false
            }
        } else {
            false
        };
        if (v15) {
            abort 10
        };
        let v16 = arg0.last_window_twap * v14;
        let v17 = if (arg1 >= arg0.last_window_twap) {
            if (v16 > 340282366920938463463374607431768211455 - v13) {
                abort 11
            };
            v16 + v13
        } else {
            v16 - v13
        };
        let v18 = if ((arg2 as u128) > 340282366920938463463374607431768211455 / (arg0.twap_cap_step as u128)) {
            340282366920938463463374607431768211455
        } else {
            (arg2 as u128) * (arg0.twap_cap_step as u128)
        };
        let v19 = if (arg1 >= arg0.last_window_twap) {
            0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::math::saturating_add(arg0.last_window_twap, 0x1::u128::min(v18, v0))
        } else {
            0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::math::saturating_sub(arg0.last_window_twap, 0x1::u128::min(v18, v0))
        };
        arg0.last_timestamp = arg3;
        arg0.last_window_end = arg3;
        let v20 = (v17 as u256) * (60000 as u256);
        arg0.last_window_end_cumulative_price = arg0.total_cumulative_price + v20;
        arg0.total_cumulative_price = arg0.total_cumulative_price + v20;
        arg0.last_price = v19;
        let v21 = PriceEvent{last_price: arg0.last_price};
        0x2::event::emit<PriceEvent>(v21);
        arg0.last_window_twap = v19;
    }

    public(friend) fun new_oracle(arg0: u128, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Oracle {
        assert!(arg0 > 0, 3);
        assert!(arg2 > 0, 4);
        assert!(arg1 < 604800000, 5);
        assert!(arg1 % 60000 == 0, 13);
        Oracle{
            id                               : 0x2::object::new(arg3),
            last_price                       : arg0,
            last_timestamp                   : 0,
            total_cumulative_price           : 0,
            last_window_end_cumulative_price : 0,
            last_window_end                  : 0,
            last_window_twap                 : arg0,
            twap_start_delay                 : arg1,
            twap_cap_step                    : arg2,
            market_start_time                : 0x1::option::none<u64>(),
            twap_initialization_price        : arg0,
        }
    }

    fun one_step_cap_price_change(arg0: u128, arg1: u128, arg2: u64) : u128 {
        if (arg1 > arg0) {
            0x1::u128::min(arg1, 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::math::saturating_add(arg0, (arg2 as u128)))
        } else {
            0x1::u128::max(arg1, 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::math::saturating_sub(arg0, (arg2 as u128)))
        }
    }

    public(friend) fun set_oracle_start_time(arg0: &mut Oracle, arg1: u64) {
        assert!(0x1::option::is_none<u64>(&arg0.market_start_time), 15);
        arg0.market_start_time = 0x1::option::some<u64>(arg1);
        arg0.last_window_end = arg1;
        arg0.last_timestamp = arg1;
    }

    fun twap_accumulate(arg0: &mut Oracle, arg1: u64, arg2: u128) {
        assert!(arg1 >= arg0.last_timestamp, 0);
        assert!(arg0.last_timestamp >= arg0.last_window_end, 0);
        let v0 = 0x1::u64::min(60000 - (arg0.last_timestamp - arg0.last_window_end) % 60000, arg1 - arg0.last_timestamp);
        if (v0 > 0) {
            let v1 = arg0.last_timestamp + v0;
            intra_window_accumulation(arg0, arg2, v0, v1);
        };
        let v2 = arg1 - arg0.last_timestamp;
        if (v2 >= 60000) {
            let v3 = v2 / 60000;
            let v4 = arg0.last_timestamp + v3 * 60000;
            multi_full_window_accumulation(arg0, arg2, v3, v4);
        };
        let v5 = arg1 - arg0.last_timestamp;
        if (v5 > 0) {
            intra_window_accumulation(arg0, arg2, v5, arg1);
        };
        assert!(arg0.last_timestamp == arg1, 12);
    }

    public(friend) fun write_observation(arg0: &mut Oracle, arg1: u64, arg2: u128) {
        assert!(0x1::option::is_some<u64>(&arg0.market_start_time), 14);
        assert!(arg1 >= arg0.last_timestamp, 0);
        let v0 = *0x1::option::borrow<u64>(&arg0.market_start_time) + arg0.twap_start_delay;
        if (arg1 == arg0.last_timestamp) {
            return
        };
        if (arg0.last_timestamp < v0 && arg1 < v0) {
            twap_accumulate(arg0, arg1, arg2);
            return
        };
        if (arg0.last_timestamp <= v0 && arg1 >= v0) {
            if (v0 > arg0.last_timestamp) {
                twap_accumulate(arg0, v0, arg2);
            };
            arg0.total_cumulative_price = 0;
            arg0.last_window_end_cumulative_price = 0;
            arg0.last_window_end = v0;
            if (arg1 > v0) {
                twap_accumulate(arg0, arg1, arg2);
            };
            return
        };
        if (arg0.last_timestamp >= v0) {
            twap_accumulate(arg0, arg1, arg2);
            return
        };
    }

    // decompiled from Move bytecode v6
}

