module 0x9b6e631ee7508b557b0bd60a1ac685efea4d67982cfb2c57bc940dd9a3f0de51::oracle {
    struct OracleConfig has copy, drop, store {
        feed_a: vector<u8>,
        feed_b: vector<u8>,
        dec_a: u8,
        dec_b: u8,
        max_age_s: u64,
        max_conf_bps: u64,
    }

    struct OracleKey has copy, drop, store {
        pool_id: 0x2::object::ID,
    }

    struct OracleRegistered has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
    }

    public(friend) fun assert_pool_near_oracle(arg0: &0x9b6e631ee7508b557b0bd60a1ac685efea4d67982cfb2c57bc940dd9a3f0de51::balance_manager::CapitalVault, arg1: 0x2::object::ID, arg2: u128, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock) {
        let v0 = config(arg0, arg1);
        let (v1, v2) = checked_price(arg3, &v0.feed_a, v0.max_age_s, v0.max_conf_bps, arg5);
        let (v3, v4) = checked_price(arg4, &v0.feed_b, v0.max_age_s, v0.max_conf_bps, arg5);
        assert!(within_deviation(arg2, v1, v2, v3, v4, v0.dec_a, v0.dec_b, 500), 208);
    }

    public(friend) fun assert_swap_floor(arg0: &0x9b6e631ee7508b557b0bd60a1ac685efea4d67982cfb2c57bc940dd9a3f0de51::balance_manager::CapitalVault, arg1: 0x2::object::ID, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        let v0 = config(arg0, arg1);
        let (v1, v2) = if (arg4) {
            checked_price(arg2, &v0.feed_a, v0.max_age_s, v0.max_conf_bps, arg8)
        } else {
            checked_price(arg3, &v0.feed_b, v0.max_age_s, v0.max_conf_bps, arg8)
        };
        let (v3, v4) = if (arg4) {
            checked_price(arg3, &v0.feed_b, v0.max_age_s, v0.max_conf_bps, arg8)
        } else {
            checked_price(arg2, &v0.feed_a, v0.max_age_s, v0.max_conf_bps, arg8)
        };
        let (v5, v6) = if (arg4) {
            (v0.dec_a, v0.dec_b)
        } else {
            (v0.dec_b, v0.dec_a)
        };
        let v7 = compute_min_out(v1, v2, v3, v4, v5, v6, arg5, 50);
        let v8 = if (arg7 > v7) {
            arg7
        } else {
            v7
        };
        assert!(arg6 >= v8, 205);
    }

    fun checked_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &vector<u8>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg4, arg2);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2) == *arg1, 200);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v3), 201);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3);
        assert!(v4 > 0, 201);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v5), 202);
        assert!((0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0) as u128) * 10000 <= (v4 as u128) * (arg3 as u128), 203);
        (v4, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v5))
    }

    fun compute_min_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: u8, arg6: u64, arg7: u128) : u64 {
        let v0 = (arg6 as u128) * (arg0 as u128) * (10000 - arg7);
        let v1 = v0;
        let v2 = (arg2 as u128) * 10000;
        let v3 = v2;
        let v4 = (arg5 as u64) + arg3;
        let v5 = (arg4 as u64) + arg1;
        let v6 = if (v4 >= v5) {
            v4 - v5
        } else {
            v5 - v4
        };
        assert!(v6 <= 38, 204);
        if (v4 >= v5) {
            v1 = v0 * pow10((v6 as u8));
        } else {
            v3 = v2 * pow10((v6 as u8));
        };
        let v7 = v1 / v3;
        assert!(v7 <= 18446744073709551615, 204);
        (v7 as u64)
    }

    fun config(arg0: &0x9b6e631ee7508b557b0bd60a1ac685efea4d67982cfb2c57bc940dd9a3f0de51::balance_manager::CapitalVault, arg1: 0x2::object::ID) : OracleConfig {
        let v0 = 0x9b6e631ee7508b557b0bd60a1ac685efea4d67982cfb2c57bc940dd9a3f0de51::balance_manager::borrow_extra(arg0);
        let v1 = OracleKey{pool_id: arg1};
        assert!(0x2::bag::contains<OracleKey>(v0, v1), 206);
        let v2 = OracleKey{pool_id: arg1};
        *0x2::bag::borrow<OracleKey, OracleConfig>(v0, v2)
    }

    public fun has_oracle(arg0: &0x9b6e631ee7508b557b0bd60a1ac685efea4d67982cfb2c57bc940dd9a3f0de51::balance_manager::CapitalVault, arg1: 0x2::object::ID) : bool {
        let v0 = OracleKey{pool_id: arg1};
        0x2::bag::contains<OracleKey>(0x9b6e631ee7508b557b0bd60a1ac685efea4d67982cfb2c57bc940dd9a3f0de51::balance_manager::borrow_extra(arg0), v0)
    }

    fun pow10(arg0: u8) : u128 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun register_oracle(arg0: &mut 0x9b6e631ee7508b557b0bd60a1ac685efea4d67982cfb2c57bc940dd9a3f0de51::balance_manager::CapitalVault, arg1: &0x9b6e631ee7508b557b0bd60a1ac685efea4d67982cfb2c57bc940dd9a3f0de51::balance_manager::AdminCap, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: u8, arg7: u64, arg8: u64) {
        0x9b6e631ee7508b557b0bd60a1ac685efea4d67982cfb2c57bc940dd9a3f0de51::balance_manager::assert_admin_pkg(arg0, arg1);
        assert!(0x1::vector::length<u8>(&arg3) == 32 && 0x1::vector::length<u8>(&arg4) == 32, 207);
        let v0 = OracleConfig{
            feed_a       : arg3,
            feed_b       : arg4,
            dec_a        : arg5,
            dec_b        : arg6,
            max_age_s    : arg7,
            max_conf_bps : arg8,
        };
        let v1 = OracleKey{pool_id: arg2};
        let v2 = 0x9b6e631ee7508b557b0bd60a1ac685efea4d67982cfb2c57bc940dd9a3f0de51::balance_manager::borrow_extra_mut(arg0);
        if (0x2::bag::contains<OracleKey>(v2, v1)) {
            0x2::bag::remove<OracleKey, OracleConfig>(v2, v1);
        };
        0x2::bag::add<OracleKey, OracleConfig>(v2, v1, v0);
        let v3 = OracleRegistered{
            vault_id : 0x2::object::id<0x9b6e631ee7508b557b0bd60a1ac685efea4d67982cfb2c57bc940dd9a3f0de51::balance_manager::CapitalVault>(arg0),
            pool_id  : arg2,
        };
        0x2::event::emit<OracleRegistered>(v3);
    }

    fun within_deviation(arg0: u128, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: u8, arg7: u64) : bool {
        let v0 = 340282366920938463463374607431768211456;
        let v1 = arg4 + (arg6 as u64);
        let v2 = arg2 + (arg5 as u64);
        let v3 = if (v1 >= v2) {
            v1 - v2
        } else {
            v2 - v1
        };
        assert!(v3 <= 38, 204);
        let v4 = (arg1 as u256);
        let v5 = v4;
        let v6 = (arg3 as u256);
        let v7 = v6;
        if (v1 >= v2) {
            v5 = v4 * (pow10((v3 as u8)) as u256);
        } else {
            v7 = v6 * (pow10((v3 as u8)) as u256);
        };
        let v8 = (arg0 as u256) * (arg0 as u256) * v7 * (10000 as u256);
        v5 * ((10000 - (arg7 as u128)) as u256) * v0 <= v8 && v8 <= v5 * ((10000 + (arg7 as u128)) as u256) * v0
    }

    // decompiled from Move bytecode v7
}

