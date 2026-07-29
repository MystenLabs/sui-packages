module 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface {
    struct OracleAdminCap has store, key {
        id: 0x2::object::UID,
        feed_id: 0x2::object::ID,
    }

    struct CollateralSampleTsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PrincipalSampleTsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct OracleFeed has key {
        id: 0x2::object::UID,
        admin: address,
        collateral_price: u64,
        principal_price: u64,
        decimals: u8,
        last_update_ms: u64,
        recent_collateral_prices: vector<u64>,
        recent_principal_prices: vector<u64>,
    }

    public fun assert_buyout_prices_with_reference(arg0: &OracleFeed, arg1: &0x2::clock::Clock) : (u64, u64) {
        assert_feed_fresh(arg0, arg1);
        let v0 = arg0.collateral_price;
        let v1 = arg0.principal_price;
        guard_price_deviation(&arg0.recent_collateral_prices, v0);
        guard_price_deviation(&arg0.recent_principal_prices, v1);
        (v0, v1)
    }

    fun assert_feed_fresh(arg0: &OracleFeed, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg0.last_update_ms <= v0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::oracle_stale());
        assert!(v0 - arg0.last_update_ms <= 3600 * 1000, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::oracle_stale());
    }

    public fun assert_fresh(arg0: &OracleFeed, arg1: &0x2::clock::Clock) : u64 {
        assert_feed_fresh(arg0, arg1);
        assert!(arg0.collateral_price > 0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::oracle_price_invalid());
        arg0.collateral_price
    }

    public fun assert_fresh_with_reference(arg0: &OracleFeed, arg1: &0x2::clock::Clock) : u64 {
        assert_feed_fresh(arg0, arg1);
        let v0 = arg0.collateral_price;
        guard_price_deviation(&arg0.recent_collateral_prices, v0);
        v0
    }

    public fun buyout_anchor_principal_atoms(arg0: u64, arg1: u8, arg2: u64, arg3: u64, arg4: u8, arg5: u8) : u128 {
        principal_atoms_for_quote_value(token_value_quote_atoms(arg0, arg1, arg2, arg5), arg3, arg4, arg5)
    }

    public fun create_oracle_feed(arg0: address, arg1: u64, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : OracleAdminCap {
        create_oracle_feed_dual(arg0, arg1, arg1, arg2, arg3, arg4)
    }

    public fun create_oracle_feed_dual(arg0: address, arg1: u64, arg2: u64, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : OracleAdminCap {
        assert!(arg1 > 0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::oracle_price_invalid());
        assert!(arg2 > 0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::oracle_price_invalid());
        let v0 = OracleFeed{
            id                       : 0x2::object::new(arg5),
            admin                    : arg0,
            collateral_price         : arg1,
            principal_price          : arg2,
            decimals                 : arg3,
            last_update_ms           : 0x2::clock::timestamp_ms(arg4),
            recent_collateral_prices : vector[],
            recent_principal_prices  : vector[],
        };
        let v1 = CollateralSampleTsKey{dummy_field: false};
        0x2::dynamic_field::add<CollateralSampleTsKey, vector<u64>>(&mut v0.id, v1, vector[]);
        let v2 = PrincipalSampleTsKey{dummy_field: false};
        0x2::dynamic_field::add<PrincipalSampleTsKey, vector<u64>>(&mut v0.id, v2, vector[]);
        0x2::transfer::share_object<OracleFeed>(v0);
        OracleAdminCap{
            id      : 0x2::object::new(arg5),
            feed_id : 0x2::object::id<OracleFeed>(&v0),
        }
    }

    public fun get_collateral_price(arg0: &OracleFeed) : u64 {
        arg0.collateral_price
    }

    public fun get_decimals(arg0: &OracleFeed) : u8 {
        arg0.decimals
    }

    public fun get_last_update_ms(arg0: &OracleFeed) : u64 {
        arg0.last_update_ms
    }

    public fun get_price(arg0: &OracleFeed) : u64 {
        arg0.collateral_price
    }

    public fun get_principal_price(arg0: &OracleFeed) : u64 {
        arg0.principal_price
    }

    fun guard_price_deviation(arg0: &vector<u64>, arg1: u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(arg0)) {
            let v3 = *0x1::vector::borrow<u64>(arg0, v2);
            if (v3 > 0) {
                v0 = v0 + (v3 as u128);
                v1 = v1 + 1;
            };
            v2 = v2 + 1;
        };
        assert!(v1 >= 3, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::oracle_price_no_reference());
        let v4 = v0 / (v1 as u128);
        let v5 = (arg1 as u128);
        let v6 = if (v5 > v4) {
            v5 - v4
        } else {
            v4 - v5
        };
        assert!(v6 * 10000 / v4 <= (500 as u128), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::oracle_price_deviation());
    }

    public fun max_oracle_staleness_seconds() : u64 {
        3600
    }

    public fun min_sample_interval_ms() : u64 {
        60000
    }

    public fun pow10(arg0: u8) : u128 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun principal_atoms_for_quote_value(arg0: u128, arg1: u64, arg2: u8, arg3: u8) : u128 {
        assert!(arg1 > 0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::oracle_price_invalid());
        if (arg3 == 0) {
            arg0 / (arg1 as u128)
        } else {
            arg0 * pow10(arg2) * pow10(arg3) / (arg1 as u128)
        }
    }

    fun push_reference_sample(arg0: &mut vector<u64>, arg1: &mut vector<u64>, arg2: u64, arg3: u64) {
        if (0x1::vector::length<u64>(arg1) > 0) {
            assert!(arg3 >= *0x1::vector::borrow<u64>(arg1, 0x1::vector::length<u64>(arg1) - 1) + 60000, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::oracle_sample_too_soon());
        };
        0x1::vector::push_back<u64>(arg0, arg2);
        0x1::vector::push_back<u64>(arg1, arg3);
        while (0x1::vector::length<u64>(arg0) > 5) {
            0x1::vector::remove<u64>(arg0, 0);
            0x1::vector::remove<u64>(arg1, 0);
        };
    }

    public fun token_value_quote_atoms(arg0: u64, arg1: u8, arg2: u64, arg3: u8) : u128 {
        if (arg3 == 0) {
            (arg0 as u128) * (arg2 as u128)
        } else {
            (arg0 as u128) * (arg2 as u128) / pow10(arg1) * pow10(arg3)
        }
    }

    public fun update_collateral_price(arg0: &mut OracleFeed, arg1: &OracleAdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg1.feed_id == 0x2::object::id<OracleFeed>(arg0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(arg2 > 0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::oracle_price_invalid());
        arg0.collateral_price = arg2;
        arg0.last_update_ms = 0x2::clock::timestamp_ms(arg3);
        let v0 = &mut arg0.recent_collateral_prices;
        let v1 = CollateralSampleTsKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<CollateralSampleTsKey, vector<u64>>(&mut arg0.id, v1);
        push_reference_sample(v0, v2, arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public fun update_price(arg0: &mut OracleFeed, arg1: &OracleAdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        update_collateral_price(arg0, arg1, arg2, arg3);
    }

    public fun update_principal_price(arg0: &mut OracleFeed, arg1: &OracleAdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg1.feed_id == 0x2::object::id<OracleFeed>(arg0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(arg2 > 0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::oracle_price_invalid());
        arg0.principal_price = arg2;
        arg0.last_update_ms = 0x2::clock::timestamp_ms(arg3);
        let v0 = &mut arg0.recent_principal_prices;
        let v1 = PrincipalSampleTsKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<PrincipalSampleTsKey, vector<u64>>(&mut arg0.id, v1);
        push_reference_sample(v0, v2, arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public fun verify_oracle_collateralization(arg0: u64, arg1: u8, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: u8, arg7: u64) {
        assert!(token_value_quote_atoms(arg0, arg1, arg2, arg6) * 10000 >= token_value_quote_atoms(arg3, arg4, arg5, arg6) * (arg7 as u128), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::insufficient_collateralization());
    }

    // decompiled from Move bytecode v7
}

