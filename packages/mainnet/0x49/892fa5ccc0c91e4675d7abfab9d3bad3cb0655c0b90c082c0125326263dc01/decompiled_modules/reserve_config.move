module 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::reserve_config {
    struct ReserveConfig has store, key {
        id: 0x2::object::UID,
        open_ltv_pct: u8,
        close_ltv_pct: u8,
        borrow_weight_bps: u64,
        deposit_limit: u64,
        borrow_limit: u64,
        liquidation_bonus_pct: u8,
        interest_rate_utils: vector<u8>,
        interest_rate_aprs: vector<u64>,
        borrow_fee_bps: u64,
        spread_fee_bps: u64,
        liquidation_fee_bps: u64,
    }

    struct ReserveConfigBuilder has drop, store {
        open_ltv_pct: 0x1::option::Option<u8>,
        close_ltv_pct: 0x1::option::Option<u8>,
        borrow_weight_bps: 0x1::option::Option<u64>,
        deposit_limit: 0x1::option::Option<u64>,
        borrow_limit: 0x1::option::Option<u64>,
        liquidation_bonus_pct: 0x1::option::Option<u8>,
        interest_rate_utils: 0x1::option::Option<vector<u8>>,
        interest_rate_aprs: 0x1::option::Option<vector<u64>>,
        borrow_fee_bps: 0x1::option::Option<u64>,
        spread_fee_bps: 0x1::option::Option<u64>,
        liquidation_fee_bps: 0x1::option::Option<u64>,
    }

    public fun from(arg0: &ReserveConfig) : ReserveConfigBuilder {
        ReserveConfigBuilder{
            open_ltv_pct          : 0x1::option::some<u8>(arg0.open_ltv_pct),
            close_ltv_pct         : 0x1::option::some<u8>(arg0.close_ltv_pct),
            borrow_weight_bps     : 0x1::option::some<u64>(arg0.borrow_weight_bps),
            deposit_limit         : 0x1::option::some<u64>(arg0.deposit_limit),
            borrow_limit          : 0x1::option::some<u64>(arg0.borrow_limit),
            liquidation_bonus_pct : 0x1::option::some<u8>(arg0.liquidation_bonus_pct),
            interest_rate_utils   : 0x1::option::some<vector<u8>>(arg0.interest_rate_utils),
            interest_rate_aprs    : 0x1::option::some<vector<u64>>(arg0.interest_rate_aprs),
            borrow_fee_bps        : 0x1::option::some<u64>(arg0.borrow_fee_bps),
            spread_fee_bps        : 0x1::option::some<u64>(arg0.spread_fee_bps),
            liquidation_fee_bps   : 0x1::option::some<u64>(arg0.liquidation_fee_bps),
        }
    }

    public fun borrow_fee(arg0: &ReserveConfig) : 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::Decimal {
        0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from_bps(arg0.borrow_fee_bps)
    }

    public fun borrow_limit(arg0: &ReserveConfig) : u64 {
        arg0.borrow_limit
    }

    public fun borrow_weight(arg0: &ReserveConfig) : 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::Decimal {
        0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from_bps(arg0.borrow_weight_bps)
    }

    public fun build(arg0: ReserveConfigBuilder, arg1: &mut 0x2::tx_context::TxContext) : ReserveConfig {
        create_reserve_config(0x1::option::extract<u8>(&mut arg0.open_ltv_pct), 0x1::option::extract<u8>(&mut arg0.close_ltv_pct), 0x1::option::extract<u64>(&mut arg0.borrow_weight_bps), 0x1::option::extract<u64>(&mut arg0.deposit_limit), 0x1::option::extract<u64>(&mut arg0.borrow_limit), 0x1::option::extract<u8>(&mut arg0.liquidation_bonus_pct), 0x1::option::extract<u64>(&mut arg0.borrow_fee_bps), 0x1::option::extract<u64>(&mut arg0.spread_fee_bps), 0x1::option::extract<u64>(&mut arg0.liquidation_fee_bps), 0x1::option::extract<vector<u8>>(&mut arg0.interest_rate_utils), 0x1::option::extract<vector<u64>>(&mut arg0.interest_rate_aprs), arg1)
    }

    public fun calculate_apr(arg0: &ReserveConfig, arg1: 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::Decimal) : 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::Decimal {
        assert!(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::le(arg1, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from(1)), 1);
        let v0 = 1;
        while (v0 < 0x1::vector::length<u8>(&arg0.interest_rate_utils)) {
            let v1 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from_percent(*0x1::vector::borrow<u8>(&arg0.interest_rate_utils, v0 - 1));
            let v2 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from_percent(*0x1::vector::borrow<u8>(&arg0.interest_rate_utils, v0));
            if (0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::ge(arg1, v1) && 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::le(arg1, v2)) {
                let v3 = 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from_percent_u64(*0x1::vector::borrow<u64>(&arg0.interest_rate_aprs, v0 - 1));
                return 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::add(v3, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::mul(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::div(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::sub(arg1, v1), 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::sub(v2, v1)), 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::sub(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from_percent_u64(*0x1::vector::borrow<u64>(&arg0.interest_rate_aprs, v0)), v3)))
            };
            v0 = v0 + 1;
        };
        abort 0
    }

    public fun close_ltv(arg0: &ReserveConfig) : 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::Decimal {
        0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from_percent(arg0.close_ltv_pct)
    }

    public fun create_reserve_config(arg0: u8, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) : ReserveConfig {
        let v0 = ReserveConfig{
            id                    : 0x2::object::new(arg11),
            open_ltv_pct          : arg0,
            close_ltv_pct         : arg1,
            borrow_weight_bps     : arg2,
            deposit_limit         : arg3,
            borrow_limit          : arg4,
            liquidation_bonus_pct : arg5,
            interest_rate_utils   : arg9,
            interest_rate_aprs    : arg10,
            borrow_fee_bps        : arg6,
            spread_fee_bps        : arg7,
            liquidation_fee_bps   : arg8,
        };
        validate_reserve_config(&v0);
        v0
    }

    public fun deposit_limit(arg0: &ReserveConfig) : u64 {
        arg0.deposit_limit
    }

    public fun destroy(arg0: ReserveConfig) {
        let ReserveConfig {
            id                    : v0,
            open_ltv_pct          : _,
            close_ltv_pct         : _,
            borrow_weight_bps     : _,
            deposit_limit         : _,
            borrow_limit          : _,
            liquidation_bonus_pct : _,
            interest_rate_utils   : _,
            interest_rate_aprs    : _,
            borrow_fee_bps        : _,
            spread_fee_bps        : _,
            liquidation_fee_bps   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun liquidation_bonus(arg0: &ReserveConfig) : 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::Decimal {
        0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from_percent(arg0.liquidation_bonus_pct)
    }

    public fun liquidation_fee(arg0: &ReserveConfig) : 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::Decimal {
        0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from_bps(arg0.liquidation_fee_bps)
    }

    public fun open_ltv(arg0: &ReserveConfig) : 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::Decimal {
        0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from_percent(arg0.open_ltv_pct)
    }

    public fun set_borrow_weight_bps(arg0: &mut ReserveConfigBuilder, arg1: u64) {
        arg0.borrow_weight_bps = 0x1::option::some<u64>(arg1);
    }

    public fun set_close_ltv_pct(arg0: &mut ReserveConfigBuilder, arg1: u8) {
        arg0.close_ltv_pct = 0x1::option::some<u8>(arg1);
    }

    public fun set_open_ltv_pct(arg0: &mut ReserveConfigBuilder, arg1: u8) {
        arg0.open_ltv_pct = 0x1::option::some<u8>(arg1);
    }

    public fun spread_fee(arg0: &ReserveConfig) : 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::Decimal {
        0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from_bps(arg0.spread_fee_bps)
    }

    fun validate_reserve_config(arg0: &ReserveConfig) {
        assert!(arg0.open_ltv_pct <= 100, 0);
        assert!(arg0.close_ltv_pct <= 100, 0);
        assert!(arg0.open_ltv_pct <= arg0.close_ltv_pct, 0);
        assert!(arg0.borrow_weight_bps >= 10000, 0);
        assert!(arg0.liquidation_bonus_pct <= 20, 0);
        assert!(arg0.borrow_fee_bps <= 10000, 0);
        assert!(arg0.spread_fee_bps <= 10000, 0);
        assert!(arg0.liquidation_fee_bps <= 10000, 0);
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
            assert!(*0x1::vector::borrow<u64>(arg1, v1 - 1) < *0x1::vector::borrow<u64>(arg1, v1), 0);
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

