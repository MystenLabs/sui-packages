module 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::oracle {
    struct PriceOracle<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        base_decimals: u8,
        quote_decimals: u8,
        pyth_feed_id: vector<u8>,
        switchboard_aggregator_id: 0x2::object::ID,
        last_price: u64,
        last_source: u8,
        last_published_ms: u64,
        last_accepted_ms: u64,
        accepted: u64,
    }

    public fun id<T0, T1>(arg0: &PriceOracle<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun accept<T0, T1>(arg0: &mut PriceOracle<T0, T1>, arg1: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::LotusConfig, arg2: u8, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(arg0.config_id == 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::id(arg1), 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors::oracle_mismatch());
        assert!(arg3 > 0, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors::oracle_bad_source());
        let v0 = 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::oracle_config(arg1);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg4 <= v1, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors::oracle_bad_source());
        assert!(arg4 + 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::oracle_max_source_age_ms(v0) >= v1, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors::oracle_stale());
        let v2 = if (arg2 == 2) {
            if (arg0.last_source == 1) {
                arg0.last_published_ms + 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::oracle_max_source_age_ms(v0) >= v1
            } else {
                false
            }
        } else {
            false
        };
        if (v2) {
            abort 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors::oracle_primary_live()
        };
        assert_within_breaker<T0, T1>(arg0, v0, arg3, v1);
        arg0.last_price = arg3;
        arg0.last_source = arg2;
        arg0.last_published_ms = arg4;
        arg0.last_accepted_ms = v1;
        arg0.accepted = arg0.accepted + 1;
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::events::emit_oracle_price(0x2::object::uid_to_inner(&arg0.id), arg3, (arg2 as u64), v1);
    }

    fun assert_within_breaker<T0, T1>(arg0: &PriceOracle<T0, T1>, arg1: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::OracleConfig, arg2: u64, arg3: u64) {
        if (arg0.last_price == 0) {
            return
        };
        let v0 = if (arg3 > arg0.last_accepted_ms) {
            arg3 - arg0.last_accepted_ms
        } else {
            0
        };
        let v1 = (0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::oracle_max_move_bps(arg1) as u128) * ((v0 / 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::oracle_move_window_ms(arg1) + 1) as u128);
        let v2 = v1;
        if (v1 > 10000) {
            v2 = 10000;
        };
        let v3 = arg0.last_price;
        let v4 = if (arg2 > v3) {
            arg2 - v3
        } else {
            v3 - arg2
        };
        assert!((v4 as u128) * 10000 <= (v3 as u128) * v2, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors::oracle_move_rejected());
    }

    public(friend) fun base_decimals<T0, T1>(arg0: &PriceOracle<T0, T1>) : u8 {
        arg0.base_decimals
    }

    public fun config_id<T0, T1>(arg0: &PriceOracle<T0, T1>) : 0x2::object::ID {
        arg0.config_id
    }

    public fun create<T0, T1>(arg0: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::LotusConfig, arg1: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::ProtocolAdminCap, arg2: u64, arg3: u8, arg4: u8, arg5: vector<u8>, arg6: 0x2::object::ID, arg7: &mut 0x2::tx_context::TxContext) {
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::assert_governance_active(arg0, arg2);
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::assert_admin(arg0, arg1);
        assert!(arg3 <= 18 && arg4 <= 18, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors::bad_oracle_param());
        assert!(!0x1::vector::is_empty<u8>(&arg5) || arg6 != 0x2::object::id_from_address(@0x0), 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors::bad_oracle_param());
        let v0 = PriceOracle<T0, T1>{
            id                        : 0x2::object::new(arg7),
            config_id                 : 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::id(arg0),
            base_decimals             : arg3,
            quote_decimals            : arg4,
            pyth_feed_id              : arg5,
            switchboard_aggregator_id : arg6,
            last_price                : 0,
            last_source               : 0,
            last_published_ms         : 0,
            last_accepted_ms          : 0,
            accepted                  : 0,
        };
        0x2::transfer::share_object<PriceOracle<T0, T1>>(v0);
    }

    public fun fresh_price<T0, T1>(arg0: &PriceOracle<T0, T1>, arg1: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::LotusConfig, arg2: &0x2::clock::Clock) : u64 {
        assert!(arg0.config_id == 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::id(arg1), 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors::oracle_mismatch());
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::assert_designated_oracle<T0, T1>(arg1, 0x2::object::uid_to_inner(&arg0.id));
        assert!(arg0.last_price > 0, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors::oracle_stale());
        assert!(arg0.last_accepted_ms + 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::oracle_max_price_age_ms(0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::oracle_config(arg1)) >= 0x2::clock::timestamp_ms(arg2), 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors::oracle_stale());
        arg0.last_price
    }

    public fun last_accepted_ms<T0, T1>(arg0: &PriceOracle<T0, T1>) : u64 {
        arg0.last_accepted_ms
    }

    public fun last_price<T0, T1>(arg0: &PriceOracle<T0, T1>) : u64 {
        arg0.last_price
    }

    public fun last_source<T0, T1>(arg0: &PriceOracle<T0, T1>) : u8 {
        arg0.last_source
    }

    public fun normalize_human<T0, T1>(arg0: &PriceOracle<T0, T1>, arg1: u128, arg2: u8) : u64 {
        assert!(arg2 <= 38, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors::bad_oracle_param());
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
        assert!(v3 <= 18446744073709551615, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors::bad_oracle_param());
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

    public fun source_pyth() : u8 {
        1
    }

    public fun source_switchboard() : u8 {
        2
    }

    public(friend) fun switchboard_aggregator_id<T0, T1>(arg0: &PriceOracle<T0, T1>) : 0x2::object::ID {
        arg0.switchboard_aggregator_id
    }

    // decompiled from Move bytecode v7
}

