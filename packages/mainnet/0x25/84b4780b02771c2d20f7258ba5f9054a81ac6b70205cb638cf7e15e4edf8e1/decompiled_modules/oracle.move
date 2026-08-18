module 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::oracle {
    struct Observation has copy, drop, store {
        price: u64,
        observed_at_ms: u64,
    }

    struct PriceOracle<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        base_decimals: u8,
        quote_decimals: u8,
        pyth_feed_id: vector<u8>,
        switchboard_aggregator_id: 0x2::object::ID,
        deepbook_pool_id: 0x2::object::ID,
        observations: 0x2::vec_map::VecMap<u8, Observation>,
        last_price: u64,
        last_aggregated_ms: u64,
        aggregations: u64,
    }

    public fun id<T0, T1>(arg0: &PriceOracle<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun aggregate<T0, T1>(arg0: &mut PriceOracle<T0, T1>, arg1: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::LotusConfig, arg2: u64, arg3: &0x2::clock::Clock) {
        0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::assert_not_paused(arg1, arg2);
        assert!(arg0.config_id == 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::id(arg1), 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::errors::oracle_mismatch());
        let v0 = 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::oracle_config(arg1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0;
        while (v3 < 0x2::vec_map::length<u8, Observation>(&arg0.observations)) {
            let (_, v5) = 0x2::vec_map::get_entry_by_idx<u8, Observation>(&arg0.observations, v3);
            if (v5.observed_at_ms + 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::oracle_max_source_age_ms(v0) >= v1 && v5.observed_at_ms <= v1) {
                let v6 = 0;
                while (v6 < 0x1::vector::length<u64>(&v2) && *0x1::vector::borrow<u64>(&v2, v6) < v5.price) {
                    v6 = v6 + 1;
                };
                0x1::vector::insert<u64>(&mut v2, v5.price, v6);
            };
            v3 = v3 + 1;
        };
        let v7 = 0x1::vector::length<u64>(&v2);
        assert!(v7 >= (0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::oracle_min_sources(v0) as u64), 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::errors::oracle_quorum());
        let v8 = *0x1::vector::borrow<u64>(&v2, 0);
        assert!(((*0x1::vector::borrow<u64>(&v2, v7 - 1) - v8) as u128) * 10000 <= (v8 as u128) * (0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::oracle_max_spread_bps(v0) as u128), 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::errors::oracle_spread());
        let v9 = v7 / 2;
        let v10 = if (v7 % 2 == 1) {
            *0x1::vector::borrow<u64>(&v2, v9)
        } else {
            ((((*0x1::vector::borrow<u64>(&v2, v9 - 1) as u128) + (*0x1::vector::borrow<u64>(&v2, v9) as u128)) / 2) as u64)
        };
        arg0.last_price = v10;
        arg0.last_aggregated_ms = v1;
        arg0.aggregations = arg0.aggregations + 1;
        0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::events::emit_oracle_price(0x2::object::uid_to_inner(&arg0.id), v10, v7, v1);
    }

    public(friend) fun base_decimals<T0, T1>(arg0: &PriceOracle<T0, T1>) : u8 {
        arg0.base_decimals
    }

    public fun config_id<T0, T1>(arg0: &PriceOracle<T0, T1>) : 0x2::object::ID {
        arg0.config_id
    }

    public fun create<T0, T1>(arg0: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::LotusConfig, arg1: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::ProtocolAdminCap, arg2: u64, arg3: u8, arg4: u8, arg5: vector<u8>, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: &mut 0x2::tx_context::TxContext) {
        0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::assert_governance_active(arg0, arg2);
        0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::assert_admin(arg0, arg1);
        assert!(arg3 <= 18 && arg4 <= 18, 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::errors::bad_oracle_param());
        let v0 = PriceOracle<T0, T1>{
            id                        : 0x2::object::new(arg8),
            config_id                 : 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::id(arg0),
            base_decimals             : arg3,
            quote_decimals            : arg4,
            pyth_feed_id              : arg5,
            switchboard_aggregator_id : arg6,
            deepbook_pool_id          : arg7,
            observations              : 0x2::vec_map::empty<u8, Observation>(),
            last_price                : 0,
            last_aggregated_ms        : 0,
            aggregations              : 0,
        };
        0x2::transfer::share_object<PriceOracle<T0, T1>>(v0);
    }

    public(friend) fun deepbook_pool_id<T0, T1>(arg0: &PriceOracle<T0, T1>) : 0x2::object::ID {
        arg0.deepbook_pool_id
    }

    public fun fresh_price<T0, T1>(arg0: &PriceOracle<T0, T1>, arg1: &0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::LotusConfig, arg2: &0x2::clock::Clock) : u64 {
        assert!(arg0.config_id == 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::id(arg1), 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::errors::oracle_mismatch());
        assert!(arg0.last_price > 0, 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::errors::oracle_stale());
        assert!(arg0.last_aggregated_ms + 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::oracle_max_price_age_ms(0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::config::oracle_config(arg1)) >= 0x2::clock::timestamp_ms(arg2), 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::errors::oracle_stale());
        arg0.last_price
    }

    public fun last_aggregated_ms<T0, T1>(arg0: &PriceOracle<T0, T1>) : u64 {
        arg0.last_aggregated_ms
    }

    public fun last_price<T0, T1>(arg0: &PriceOracle<T0, T1>) : u64 {
        arg0.last_price
    }

    public fun normalize_human<T0, T1>(arg0: &PriceOracle<T0, T1>, arg1: u128, arg2: u8) : u64 {
        assert!(arg2 <= 38, 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::errors::bad_oracle_param());
        let v0 = (arg1 as u256) * (1000000000 as u256);
        let v1 = 0;
        while (v1 < arg0.quote_decimals) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        let v2 = 1;
        v1 = 0;
        while (v1 < arg2) {
            v2 = v2 * 10;
            v1 = v1 + 1;
        };
        v1 = 0;
        while (v1 < arg0.base_decimals) {
            v2 = v2 * 10;
            v1 = v1 + 1;
        };
        let v3 = v0 / v2;
        assert!(v3 <= 18446744073709551615, 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::errors::bad_oracle_param());
        (v3 as u64)
    }

    public fun price_scale() : u64 {
        1000000000
    }

    public(friend) fun pyth_feed_id<T0, T1>(arg0: &PriceOracle<T0, T1>) : &vector<u8> {
        &arg0.pyth_feed_id
    }

    public(friend) fun quote_decimals<T0, T1>(arg0: &PriceOracle<T0, T1>) : u8 {
        arg0.quote_decimals
    }

    public fun quote_value(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (1000000000 as u128)) as u64)
    }

    public fun source_deepbook_mid() : u8 {
        4
    }

    public fun source_pyth() : u8 {
        1
    }

    public fun source_supra() : u8 {
        3
    }

    public fun source_switchboard() : u8 {
        2
    }

    public(friend) fun submit<T0, T1>(arg0: &mut PriceOracle<T0, T1>, arg1: u8, arg2: u64, arg3: u64) {
        assert!(arg2 > 0, 0x2584b4780b02771c2d20f7258ba5f9054a81ac6b70205cb638cf7e15e4edf8e1::errors::oracle_bad_source());
        let v0 = Observation{
            price          : arg2,
            observed_at_ms : arg3,
        };
        if (0x2::vec_map::contains<u8, Observation>(&arg0.observations, &arg1)) {
            *0x2::vec_map::get_mut<u8, Observation>(&mut arg0.observations, &arg1) = v0;
        } else {
            0x2::vec_map::insert<u8, Observation>(&mut arg0.observations, arg1, v0);
        };
    }

    public(friend) fun switchboard_aggregator_id<T0, T1>(arg0: &PriceOracle<T0, T1>) : 0x2::object::ID {
        arg0.switchboard_aggregator_id
    }

    // decompiled from Move bytecode v7
}

