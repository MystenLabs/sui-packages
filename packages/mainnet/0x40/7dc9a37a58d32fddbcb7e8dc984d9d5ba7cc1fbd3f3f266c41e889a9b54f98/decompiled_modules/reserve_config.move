module 0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::reserve_config {
    struct ReserveConfig has store {
        open_ltv_pct: u8,
        close_ltv_pct: u8,
        max_close_ltv_pct: u8,
        borrow_weight_bps: u64,
        deposit_limit: u64,
        borrow_limit: u64,
        liquidation_bonus_bps: u64,
        max_liquidation_bonus_bps: u64,
        deposit_limit_usd: u64,
        borrow_limit_usd: u64,
        interest_rate_utils: vector<u8>,
        interest_rate_aprs: vector<u64>,
        borrow_fee_bps: u64,
        spread_fee_bps: u64,
        protocol_liquidation_fee_bps: u64,
        isolated: bool,
        open_attributed_borrow_limit_usd: u64,
        close_attributed_borrow_limit_usd: u64,
        additional_fields: 0x2::bag::Bag,
    }

    struct ReserveConfigBuilder has store {
        fields: 0x2::bag::Bag,
    }

    public fun from(arg0: &ReserveConfig, arg1: &mut 0x2::tx_context::TxContext) : ReserveConfigBuilder {
        let v0 = ReserveConfigBuilder{fields: 0x2::bag::new(arg1)};
        let v1 = &mut v0;
        set_open_ltv_pct(v1, arg0.open_ltv_pct);
        let v2 = &mut v0;
        set_close_ltv_pct(v2, arg0.close_ltv_pct);
        let v3 = &mut v0;
        set_max_close_ltv_pct(v3, arg0.max_close_ltv_pct);
        let v4 = &mut v0;
        set_borrow_weight_bps(v4, arg0.borrow_weight_bps);
        let v5 = &mut v0;
        set_deposit_limit(v5, arg0.deposit_limit);
        let v6 = &mut v0;
        set_borrow_limit(v6, arg0.borrow_limit);
        let v7 = &mut v0;
        set_liquidation_bonus_bps(v7, arg0.liquidation_bonus_bps);
        let v8 = &mut v0;
        set_max_liquidation_bonus_bps(v8, arg0.max_liquidation_bonus_bps);
        let v9 = &mut v0;
        set_deposit_limit_usd(v9, arg0.deposit_limit_usd);
        let v10 = &mut v0;
        set_borrow_limit_usd(v10, arg0.borrow_limit_usd);
        let v11 = &mut v0;
        set_interest_rate_utils(v11, arg0.interest_rate_utils);
        let v12 = &mut v0;
        set_interest_rate_aprs(v12, arg0.interest_rate_aprs);
        let v13 = &mut v0;
        set_borrow_fee_bps(v13, arg0.borrow_fee_bps);
        let v14 = &mut v0;
        set_spread_fee_bps(v14, arg0.spread_fee_bps);
        let v15 = &mut v0;
        set_protocol_liquidation_fee_bps(v15, arg0.protocol_liquidation_fee_bps);
        let v16 = &mut v0;
        set_isolated(v16, arg0.isolated);
        let v17 = &mut v0;
        set_open_attributed_borrow_limit_usd(v17, arg0.open_attributed_borrow_limit_usd);
        let v18 = &mut v0;
        set_close_attributed_borrow_limit_usd(v18, arg0.close_attributed_borrow_limit_usd);
        v0
    }

    public fun borrow_fee(arg0: &ReserveConfig) : 0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::Decimal {
        0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::from_bps(arg0.borrow_fee_bps)
    }

    public fun borrow_limit(arg0: &ReserveConfig) : u64 {
        arg0.borrow_limit
    }

    public fun borrow_limit_usd(arg0: &ReserveConfig) : u64 {
        arg0.borrow_limit_usd
    }

    public fun borrow_weight(arg0: &ReserveConfig) : 0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::Decimal {
        0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::from_bps(arg0.borrow_weight_bps)
    }

    public fun build(arg0: ReserveConfigBuilder, arg1: &mut 0x2::tx_context::TxContext) : ReserveConfig {
        let ReserveConfigBuilder { fields: v0 } = arg0;
        0x2::bag::destroy_empty(v0);
        create_reserve_config(0x2::bag::remove<vector<u8>, u8>(&mut arg0.fields, b"open_ltv_pct"), 0x2::bag::remove<vector<u8>, u8>(&mut arg0.fields, b"close_ltv_pct"), 0x2::bag::remove<vector<u8>, u8>(&mut arg0.fields, b"max_close_ltv_pct"), 0x2::bag::remove<vector<u8>, u64>(&mut arg0.fields, b"borrow_weight_bps"), 0x2::bag::remove<vector<u8>, u64>(&mut arg0.fields, b"deposit_limit"), 0x2::bag::remove<vector<u8>, u64>(&mut arg0.fields, b"borrow_limit"), 0x2::bag::remove<vector<u8>, u64>(&mut arg0.fields, b"liquidation_bonus_bps"), 0x2::bag::remove<vector<u8>, u64>(&mut arg0.fields, b"max_liquidation_bonus_bps"), 0x2::bag::remove<vector<u8>, u64>(&mut arg0.fields, b"deposit_limit_usd"), 0x2::bag::remove<vector<u8>, u64>(&mut arg0.fields, b"borrow_limit_usd"), 0x2::bag::remove<vector<u8>, u64>(&mut arg0.fields, b"borrow_fee_bps"), 0x2::bag::remove<vector<u8>, u64>(&mut arg0.fields, b"spread_fee_bps"), 0x2::bag::remove<vector<u8>, u64>(&mut arg0.fields, b"protocol_liquidation_fee_bps"), 0x2::bag::remove<vector<u8>, vector<u8>>(&mut arg0.fields, b"interest_rate_utils"), 0x2::bag::remove<vector<u8>, vector<u64>>(&mut arg0.fields, b"interest_rate_aprs"), 0x2::bag::remove<vector<u8>, bool>(&mut arg0.fields, b"isolated"), 0x2::bag::remove<vector<u8>, u64>(&mut arg0.fields, b"open_attributed_borrow_limit_usd"), 0x2::bag::remove<vector<u8>, u64>(&mut arg0.fields, b"close_attributed_borrow_limit_usd"), arg1)
    }

    public fun calculate_apr(arg0: &ReserveConfig, arg1: 0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::Decimal) : 0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::Decimal {
        assert!(0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::le(arg1, 0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::from(1)), 1);
        let v0 = 1;
        while (v0 < 0x1::vector::length<u8>(&arg0.interest_rate_utils)) {
            let v1 = 0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::from_percent(*0x1::vector::borrow<u8>(&arg0.interest_rate_utils, v0 - 1));
            let v2 = 0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::from_percent(*0x1::vector::borrow<u8>(&arg0.interest_rate_utils, v0));
            if (0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::ge(arg1, v1) && 0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::le(arg1, v2)) {
                let v3 = 0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::from_bps(*0x1::vector::borrow<u64>(&arg0.interest_rate_aprs, v0 - 1));
                return 0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::add(v3, 0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::mul(0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::div(0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::sub(arg1, v1), 0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::sub(v2, v1)), 0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::sub(0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::from_bps(*0x1::vector::borrow<u64>(&arg0.interest_rate_aprs, v0)), v3)))
            };
            v0 = v0 + 1;
        };
        abort 0
    }

    public fun calculate_supply_apr(arg0: &ReserveConfig, arg1: 0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::Decimal, arg2: 0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::Decimal) : 0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::Decimal {
        0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::mul(0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::mul(0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::sub(0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::from(1), spread_fee(arg0)), arg2), arg1)
    }

    public fun close_ltv(arg0: &ReserveConfig) : 0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::Decimal {
        0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::from_percent(arg0.close_ltv_pct)
    }

    public fun create_reserve_config(arg0: u8, arg1: u8, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: vector<u8>, arg14: vector<u64>, arg15: bool, arg16: u64, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) : ReserveConfig {
        let v0 = ReserveConfig{
            open_ltv_pct                      : arg0,
            close_ltv_pct                     : arg1,
            max_close_ltv_pct                 : arg2,
            borrow_weight_bps                 : arg3,
            deposit_limit                     : arg4,
            borrow_limit                      : arg5,
            liquidation_bonus_bps             : arg6,
            max_liquidation_bonus_bps         : arg7,
            deposit_limit_usd                 : arg8,
            borrow_limit_usd                  : arg9,
            interest_rate_utils               : arg13,
            interest_rate_aprs                : arg14,
            borrow_fee_bps                    : arg10,
            spread_fee_bps                    : arg11,
            protocol_liquidation_fee_bps      : arg12,
            isolated                          : arg15,
            open_attributed_borrow_limit_usd  : arg16,
            close_attributed_borrow_limit_usd : arg17,
            additional_fields                 : 0x2::bag::new(arg18),
        };
        validate_reserve_config(&v0);
        v0
    }

    public fun deposit_limit(arg0: &ReserveConfig) : u64 {
        arg0.deposit_limit
    }

    public fun deposit_limit_usd(arg0: &ReserveConfig) : u64 {
        arg0.deposit_limit_usd
    }

    public fun destroy(arg0: ReserveConfig) {
        let ReserveConfig {
            open_ltv_pct                      : _,
            close_ltv_pct                     : _,
            max_close_ltv_pct                 : _,
            borrow_weight_bps                 : _,
            deposit_limit                     : _,
            borrow_limit                      : _,
            liquidation_bonus_bps             : _,
            max_liquidation_bonus_bps         : _,
            deposit_limit_usd                 : _,
            borrow_limit_usd                  : _,
            interest_rate_utils               : _,
            interest_rate_aprs                : _,
            borrow_fee_bps                    : _,
            spread_fee_bps                    : _,
            protocol_liquidation_fee_bps      : _,
            isolated                          : _,
            open_attributed_borrow_limit_usd  : _,
            close_attributed_borrow_limit_usd : _,
            additional_fields                 : v18,
        } = arg0;
        0x2::bag::destroy_empty(v18);
    }

    public fun isolated(arg0: &ReserveConfig) : bool {
        arg0.isolated
    }

    public fun liquidation_bonus(arg0: &ReserveConfig) : 0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::Decimal {
        0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::from_bps(arg0.liquidation_bonus_bps)
    }

    public fun open_ltv(arg0: &ReserveConfig) : 0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::Decimal {
        0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::from_percent(arg0.open_ltv_pct)
    }

    public fun protocol_liquidation_fee(arg0: &ReserveConfig) : 0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::Decimal {
        0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::from_bps(arg0.protocol_liquidation_fee_bps)
    }

    fun set<T0: copy + drop + store, T1: drop + store>(arg0: &mut ReserveConfigBuilder, arg1: T0, arg2: T1) {
        if (0x2::bag::contains<T0>(&arg0.fields, arg1)) {
            *0x2::bag::borrow_mut<T0, T1>(&mut arg0.fields, arg1) = arg2;
        } else {
            0x2::bag::add<T0, T1>(&mut arg0.fields, arg1, arg2);
        };
    }

    public fun set_borrow_fee_bps(arg0: &mut ReserveConfigBuilder, arg1: u64) {
        set<vector<u8>, u64>(arg0, b"borrow_fee_bps", arg1);
    }

    public fun set_borrow_limit(arg0: &mut ReserveConfigBuilder, arg1: u64) {
        set<vector<u8>, u64>(arg0, b"borrow_limit", arg1);
    }

    public fun set_borrow_limit_usd(arg0: &mut ReserveConfigBuilder, arg1: u64) {
        set<vector<u8>, u64>(arg0, b"borrow_limit_usd", arg1);
    }

    public fun set_borrow_weight_bps(arg0: &mut ReserveConfigBuilder, arg1: u64) {
        set<vector<u8>, u64>(arg0, b"borrow_weight_bps", arg1);
    }

    public fun set_close_attributed_borrow_limit_usd(arg0: &mut ReserveConfigBuilder, arg1: u64) {
        set<vector<u8>, u64>(arg0, b"close_attributed_borrow_limit_usd", arg1);
    }

    public fun set_close_ltv_pct(arg0: &mut ReserveConfigBuilder, arg1: u8) {
        set<vector<u8>, u8>(arg0, b"close_ltv_pct", arg1);
    }

    public fun set_deposit_limit(arg0: &mut ReserveConfigBuilder, arg1: u64) {
        set<vector<u8>, u64>(arg0, b"deposit_limit", arg1);
    }

    public fun set_deposit_limit_usd(arg0: &mut ReserveConfigBuilder, arg1: u64) {
        set<vector<u8>, u64>(arg0, b"deposit_limit_usd", arg1);
    }

    public fun set_interest_rate_aprs(arg0: &mut ReserveConfigBuilder, arg1: vector<u64>) {
        set<vector<u8>, vector<u64>>(arg0, b"interest_rate_aprs", arg1);
    }

    public fun set_interest_rate_utils(arg0: &mut ReserveConfigBuilder, arg1: vector<u8>) {
        set<vector<u8>, vector<u8>>(arg0, b"interest_rate_utils", arg1);
    }

    public fun set_isolated(arg0: &mut ReserveConfigBuilder, arg1: bool) {
        set<vector<u8>, bool>(arg0, b"isolated", arg1);
    }

    public fun set_liquidation_bonus_bps(arg0: &mut ReserveConfigBuilder, arg1: u64) {
        set<vector<u8>, u64>(arg0, b"liquidation_bonus_bps", arg1);
    }

    public fun set_max_close_ltv_pct(arg0: &mut ReserveConfigBuilder, arg1: u8) {
        set<vector<u8>, u8>(arg0, b"max_close_ltv_pct", arg1);
    }

    public fun set_max_liquidation_bonus_bps(arg0: &mut ReserveConfigBuilder, arg1: u64) {
        set<vector<u8>, u64>(arg0, b"max_liquidation_bonus_bps", arg1);
    }

    public fun set_open_attributed_borrow_limit_usd(arg0: &mut ReserveConfigBuilder, arg1: u64) {
        set<vector<u8>, u64>(arg0, b"open_attributed_borrow_limit_usd", arg1);
    }

    public fun set_open_ltv_pct(arg0: &mut ReserveConfigBuilder, arg1: u8) {
        set<vector<u8>, u8>(arg0, b"open_ltv_pct", arg1);
    }

    public fun set_protocol_liquidation_fee_bps(arg0: &mut ReserveConfigBuilder, arg1: u64) {
        set<vector<u8>, u64>(arg0, b"protocol_liquidation_fee_bps", arg1);
    }

    public fun set_spread_fee_bps(arg0: &mut ReserveConfigBuilder, arg1: u64) {
        set<vector<u8>, u64>(arg0, b"spread_fee_bps", arg1);
    }

    public fun spread_fee(arg0: &ReserveConfig) : 0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::Decimal {
        0x407dc9a37a58d32fddbcb7e8dc984d9d5ba7cc1fbd3f3f266c41e889a9b54f98::decimal::from_bps(arg0.spread_fee_bps)
    }

    fun validate_reserve_config(arg0: &ReserveConfig) {
        assert!(arg0.open_ltv_pct <= 100, 0);
        assert!(arg0.close_ltv_pct <= 100, 0);
        assert!(arg0.max_close_ltv_pct <= 100, 0);
        assert!(arg0.open_ltv_pct <= arg0.close_ltv_pct, 0);
        assert!(arg0.close_ltv_pct <= arg0.max_close_ltv_pct, 0);
        assert!(arg0.borrow_weight_bps >= 10000, 0);
        assert!(arg0.liquidation_bonus_bps <= arg0.max_liquidation_bonus_bps, 0);
        assert!(arg0.max_liquidation_bonus_bps + arg0.protocol_liquidation_fee_bps <= 2000, 0);
        if (arg0.isolated) {
            assert!(arg0.open_ltv_pct == 0 && arg0.close_ltv_pct == 0, 0);
        };
        assert!(arg0.borrow_fee_bps <= 10000, 0);
        assert!(arg0.spread_fee_bps <= 10000, 0);
        assert!(arg0.open_attributed_borrow_limit_usd <= arg0.close_attributed_borrow_limit_usd, 0);
        validate_utils_and_aprs(&arg0.interest_rate_utils, &arg0.interest_rate_aprs);
    }

    fun validate_utils_and_aprs(arg0: &vector<u8>, arg1: &vector<u64>) {
        assert!(0x1::vector::length<u8>(arg0) >= 2, 0);
        assert!(0x1::vector::length<u8>(arg0) == 0x1::vector::length<u64>(arg1), 0);
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(*0x1::vector::borrow<u8>(arg0, 0) == 0, 0);
        assert!(*0x1::vector::borrow<u8>(arg0, v0 - 1) == 100, 0);
        let v1 = 1;
        while (v1 < v0) {
            assert!(*0x1::vector::borrow<u8>(arg0, v1 - 1) < *0x1::vector::borrow<u8>(arg0, v1), 0);
            assert!(*0x1::vector::borrow<u64>(arg1, v1 - 1) <= *0x1::vector::borrow<u64>(arg1, v1), 0);
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

