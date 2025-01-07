module 0x4fb95f1827704bfab3b09488033df97c225d6b91dba1655d578248e0b1352bea::pyth {
    struct PythPriceInfo has copy, drop {
        pio_map: 0x2::vec_map::VecMap<0x2::object::ID, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>,
        current_ts_sec: u64,
        max_age_secs: u64,
    }

    struct ValidatedPythPriceInfo has copy, drop {
        map: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>,
        current_ts_sec: u64,
        max_age_secs: u64,
    }

    public fun add(arg0: &mut PythPriceInfo, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg1);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(&v0));
        0x2::vec_map::insert<0x2::object::ID, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(&mut arg0.pio_map, 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1), v0);
        arg0.max_age_secs = 0x2::math::max(arg0.max_age_secs, arg0.current_ts_sec - 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v1));
    }

    public fun create(arg0: &0x2::clock::Clock) : PythPriceInfo {
        PythPriceInfo{
            pio_map        : 0x2::vec_map::empty<0x2::object::ID, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(),
            current_ts_sec : 0x2::clock::timestamp_ms(arg0) / 1000,
            max_age_secs   : 0,
        }
    }

    public fun decimals(arg0: 0x1::type_name::TypeName) : u8 {
        if (arg0 == 0x1::type_name::get<0x2::sui::SUI>()) {
            9
        } else if (arg0 == 0x1::type_name::get<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>()) {
            6
        } else {
            assert!(arg0 == 0x1::type_name::get<0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN>(), 0);
            6
        }
    }

    public fun div_price_numeric_x128(arg0: &ValidatedPythPriceInfo, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName) : u256 {
        let (v0, _, _, v3, v4) = get_price_lo_hi_expo_dec(arg0, arg1);
        let (v5, _, _, v8, v9) = get_price_lo_hi_expo_dec(arg0, arg2);
        let (v10, v11) = if (v8 + v9 > v3 + v4) {
            (0x2::math::pow(10, ((v8 + v9 - v3 - v4) as u8)), 1)
        } else {
            (1, 0x2::math::pow(10, ((v3 + v4 - v8 - v9) as u8)))
        };
        assert!(v5 > 0, 2);
        let v12 = ((v0 as u256) * (v10 as u256) << 128) / (v5 as u256) * (v11 as u256);
        assert!(v12 <= 6277101735386680763835789423207666416102355444464034512895, 2);
        v12
    }

    public fun get_ema_price(arg0: &ValidatedPythPriceInfo, arg1: 0x1::type_name::TypeName) : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price {
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_ema_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(0x2::vec_map::get<0x1::type_name::TypeName, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(&arg0.map, &arg1)))
    }

    public fun get_price(arg0: &ValidatedPythPriceInfo, arg1: 0x1::type_name::TypeName) : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price {
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(0x2::vec_map::get<0x1::type_name::TypeName, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(&arg0.map, &arg1)))
    }

    fun get_price_lo_hi_expo_dec(arg0: &ValidatedPythPriceInfo, arg1: 0x1::type_name::TypeName) : (u64, u64, u64, u64, u64) {
        let v0 = get_price(arg0, arg1);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v2);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        (v3, v3 - v1, v3 + v1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v4), (decimals(arg1) as u64))
    }

    public fun max_age_secs(arg0: &ValidatedPythPriceInfo) : u64 {
        arg0.max_age_secs
    }

    public(friend) fun sui_pio_id() : 0x2::object::ID {
        0x2::object::id_from_address(@0x801dbc2f0053d34734814b2d6df491ce7807a725fe9a01ad74a07e9c51396c37)
    }

    public fun validate(arg0: &PythPriceInfo, arg1: u64, arg2: &0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::object::ID>) : ValidatedPythPriceInfo {
        assert!(arg0.max_age_secs <= arg1, 1);
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>();
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<0x1::type_name::TypeName, 0x2::object::ID>(arg2)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, 0x2::object::ID>(arg2, v1);
            0x2::vec_map::insert<0x1::type_name::TypeName, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(&mut v0, *v2, *0x2::vec_map::get<0x2::object::ID, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(&arg0.pio_map, v3));
            v1 = v1 + 1;
        };
        ValidatedPythPriceInfo{
            map            : v0,
            current_ts_sec : arg0.current_ts_sec,
            max_age_secs   : arg0.max_age_secs,
        }
    }

    public(friend) fun whusdce_pio_id() : 0x2::object::ID {
        0x2::object::id_from_address(@0x5dec622733a204ca27f5a90d8c2fad453cc6665186fd5dff13a83d0b6c9027ab)
    }

    public(friend) fun whusdte_pio_id() : 0x2::object::ID {
        0x2::object::id_from_address(@0x985e3db9f93f76ee8bace7c3dd5cc676a096accd5d9e09e9ae0fb6e492b14572)
    }

    // decompiled from Move bytecode v6
}

