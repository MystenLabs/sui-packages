module 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::update {
    struct OracleUpdateHotPotato<phantom T0> {
        feeds: 0x2::vec_map::VecMap<u8, 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::PriceFeed>,
    }

    struct SecondaryCheckUpdated has copy, drop {
        oracle: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        check_passed: bool,
        check_spot: u64,
        check_spot_time: u64,
        check_ema: u64,
        check_ema_time: u64,
        status: u64,
    }

    struct NoSecondaryCheck has copy, drop {
        oracle: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
    }

    struct PrimaryPriceUpdated has copy, drop {
        oracle: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        spot: u64,
        spot_time: u64,
        ema: u64,
        ema_time: u64,
    }

    fun check_secondary(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: &0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::asset::AssetConfig, arg3: &mut 0x2::vec_map::VecMap<u8, 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::PriceFeed>, arg4: &0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::PriceFeedComponent) : bool {
        let (v0, v1) = 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::asset::check_source(arg2);
        let v2 = v0;
        let v3 = false;
        if (0x2::vec_map::contains<u8, 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::PriceFeed>(arg3, &v2)) {
            let (_, v5) = 0x2::vec_map::remove<u8, 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::PriceFeed>(arg3, &v2);
            let v6 = v5;
            let v7 = 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::asset::is_check_pass(v1, arg4, 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::spot(&v6));
            let v8 = v7 == 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::asset::asset_check_success();
            v3 = v8;
            let v9 = SecondaryCheckUpdated{
                oracle          : arg0,
                asset           : arg1,
                check_passed    : v8,
                check_spot      : 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::value(0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::spot(&v6)),
                check_spot_time : 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::update_time(0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::spot(&v6)),
                check_ema       : 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::value(0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::ema(&v6)),
                check_ema_time  : 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::update_time(0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::ema(&v6)),
                status          : v7,
            };
            0x2::event::emit<SecondaryCheckUpdated>(v9);
        } else {
            let v10 = NoSecondaryCheck{
                oracle : arg0,
                asset  : arg1,
            };
            0x2::event::emit<NoSecondaryCheck>(v10);
        };
        v3
    }

    public fun complete_update<T0>(arg0: OracleUpdateHotPotato<T0>, arg1: &mut 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::XOracle) {
        0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::ensure_version_matches(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let OracleUpdateHotPotato { feeds: v1 } = arg0;
        let v2 = 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::asset_registry(arg1);
        assert!(0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::asset_registry::has_asset<0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::asset::AssetConfig>(v2, v0), 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::oracle_error::asset_not_registered());
        let v3 = 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::asset_registry::borrow<0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::asset::AssetConfig>(v2, v0);
        let v4 = &mut v1;
        let v5 = extract_primary_feed(v3, v4);
        let v6 = &mut v1;
        0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::update_feed_check_passed(arg1, v0, check_secondary(0x2::object::id<0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::XOracle>(arg1), v0, v3, v6, 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::spot(&v5)));
        update_primary(arg1, 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::base_token_from_u8(0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::asset::base_token_id(v3)), v0, *0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::spot(&v5), *0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::ema(&v5));
        0x2::vec_map::destroy_empty<u8, 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::PriceFeed>(v1);
    }

    fun extract_primary_feed(arg0: &0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::asset::AssetConfig, arg1: &mut 0x2::vec_map::VecMap<u8, 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::PriceFeed>) : 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::PriceFeed {
        let v0 = 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::asset::primary_source(arg0);
        assert!(0x2::vec_map::contains<u8, 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::PriceFeed>(arg1, &v0), 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::oracle_error::primary_source_missing());
        let (_, v2) = 0x2::vec_map::remove<u8, 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::PriceFeed>(arg1, &v0);
        v2
    }

    public(friend) fun insert_price_feed<T0>(arg0: OracleUpdateHotPotato<T0>, arg1: u8, arg2: 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::PriceFeed) : OracleUpdateHotPotato<T0> {
        0x2::vec_map::insert<u8, 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::PriceFeed>(&mut arg0.feeds, arg1, arg2);
        arg0
    }

    public fun start_update<T0>() : OracleUpdateHotPotato<T0> {
        OracleUpdateHotPotato<T0>{feeds: 0x2::vec_map::empty<u8, 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::PriceFeed>()}
    }

    fun update_primary(arg0: &mut 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::XOracle, arg1: 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::BaseToken, arg2: 0x1::type_name::TypeName, arg3: 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::PriceFeedComponent, arg4: 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::PriceFeedComponent) {
        assert!(0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::value(&arg3) > 0 && 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::value(&arg4) > 0, 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::oracle_error::oracle_zero_price_error());
        assert!(0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::update_time(&arg3) >= 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::cached_spot_update_time(arg0, arg1, arg2), 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::oracle_error::price_time_regressed());
        0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::update_price_feed(arg0, arg1, arg2, arg3, arg4);
        let v0 = PrimaryPriceUpdated{
            oracle    : 0x2::object::id<0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::XOracle>(arg0),
            asset     : arg2,
            spot      : 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::value(&arg3),
            spot_time : 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::update_time(&arg3),
            ema       : 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::value(&arg4),
            ema_time  : 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::price_feed::update_time(&arg4),
        };
        0x2::event::emit<PrimaryPriceUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

