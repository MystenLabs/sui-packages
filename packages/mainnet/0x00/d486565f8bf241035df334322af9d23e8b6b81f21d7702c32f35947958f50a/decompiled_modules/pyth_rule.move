module 0xff84f40af43336967eecf342b85bbd9b38e78b6be09cda95ec537c31ed6c6438::pyth_rule {
    struct PythRule has drop {
        dummy_field: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        identifier_map: 0x2::vec_map::VecMap<0x1::string::String, vector<u8>>,
        tolerance_sec_map: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    struct MaxConfBpsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MaxConfBpsConfig has store {
        default_bps: u64,
        by_symbol: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    fun borrow_max_conf_config_mut(arg0: &mut Config) : &mut MaxConfBpsConfig {
        let v0 = MaxConfBpsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<MaxConfBpsKey>(&arg0.id, v0)) {
            let v1 = MaxConfBpsKey{dummy_field: false};
            let v2 = MaxConfBpsConfig{
                default_bps : 10000,
                by_symbol   : 0x2::vec_map::empty<0x1::string::String, u64>(),
            };
            0x2::dynamic_field::add<MaxConfBpsKey, MaxConfBpsConfig>(&mut arg0.id, v1, v2);
        };
        let v3 = MaxConfBpsKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<MaxConfBpsKey, MaxConfBpsConfig>(&mut arg0.id, v3)
    }

    fun confidence_ok(arg0: u64, arg1: u64, arg2: u64) : bool {
        (arg1 as u128) * (10000 as u128) <= (arg2 as u128) * (arg0 as u128)
    }

    public fun default_max_confidence_bps(arg0: &Config) : u64 {
        let v0 = MaxConfBpsKey{dummy_field: false};
        if (0x2::dynamic_field::exists<MaxConfBpsKey>(&arg0.id, v0)) {
            let v2 = MaxConfBpsKey{dummy_field: false};
            0x2::dynamic_field::borrow<MaxConfBpsKey, MaxConfBpsConfig>(&arg0.id, v2).default_bps
        } else {
            10000
        }
    }

    fun err_invalid_price_info_object() {
        abort 1
    }

    fun err_invalid_tolerance() {
        abort 2
    }

    public fun feed(arg0: &mut 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::PriceCollector, arg1: &Config, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::symbol(arg0);
        if (!0x2::vec_map::contains<0x1::string::String, vector<u8>>(&arg1.identifier_map, &v0)) {
            let v1 = PythRule{dummy_field: false};
            0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::collect<PythRule>(arg0, v1, 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>());
            return
        };
        if (0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg4) != 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_price_info_object_id(arg3, *0x2::vec_map::get<0x1::string::String, vector<u8>>(&arg1.identifier_map, &v0))) {
            err_invalid_price_info_object();
        };
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg4);
        let v3 = 0x2::vec_map::try_get<0x1::string::String, u64>(&arg1.tolerance_sec_map, &v0);
        let v4 = if (0x1::option::is_some<u64>(&v3)) {
            0x1::option::destroy_some<u64>(v3)
        } else {
            0x1::option::destroy_none<u64>(v3);
            5
        };
        let v5 = PythRule{dummy_field: false};
        0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::collect<PythRule>(arg0, v5, price_or_abstain(&v2, &v0, arg1, 0x2::clock::timestamp_ms(arg2) / 1000, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v2), v4));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                : 0x2::object::new(arg0),
            identifier_map    : 0x2::vec_map::empty<0x1::string::String, vector<u8>>(),
            tolerance_sec_map : 0x2::vec_map::empty<0x1::string::String, u64>(),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun max_confidence_bps(arg0: &Config, arg1: 0x1::string::String) : u64 {
        resolve_max_confidence_bps(arg0, &arg1)
    }

    fun price_or_abstain(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price, arg1: &0x1::string::String, arg2: &Config, arg3: u64, arg4: u64, arg5: u64) : 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float> {
        if (0x1::u64::diff(arg3, arg4) > arg5) {
            return 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>()
        };
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(arg0);
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v0)) {
            return 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>()
        };
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v0);
        if (v1 == 0) {
            return 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>()
        };
        if (!confidence_ok(v1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(arg0), resolve_max_confidence_bps(arg2, arg1))) {
            return 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>()
        };
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(arg0);
        if (!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v2)) {
            return 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>()
        };
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v2);
        if (v3 > 18) {
            return 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>()
        };
        0x1::option::some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_fraction(v1, 0x1::u64::pow(10, (v3 as u8))))
    }

    fun resolve_max_confidence_bps(arg0: &Config, arg1: &0x1::string::String) : u64 {
        let v0 = MaxConfBpsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<MaxConfBpsKey>(&arg0.id, v0)) {
            return 10000
        };
        let v1 = MaxConfBpsKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<MaxConfBpsKey, MaxConfBpsConfig>(&arg0.id, v1);
        let v3 = 0x2::vec_map::try_get<0x1::string::String, u64>(&v2.by_symbol, arg1);
        if (0x1::option::is_some<u64>(&v3)) {
            0x1::option::destroy_some<u64>(v3)
        } else {
            0x1::option::destroy_none<u64>(v3);
            v2.default_bps
        }
    }

    public fun set_default_max_confidence_bps(arg0: &mut Config, arg1: &0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::ListingCap, arg2: u64) {
        borrow_max_conf_config_mut(arg0).default_bps = arg2;
    }

    public fun set_identifier(arg0: &mut Config, arg1: &0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::ListingCap, arg2: 0x1::string::String, arg3: vector<u8>) {
        let v0 = &mut arg0.identifier_map;
        if (0x1::vector::is_empty<u8>(&arg3)) {
            if (0x2::vec_map::contains<0x1::string::String, vector<u8>>(v0, &arg2)) {
                let (_, _) = 0x2::vec_map::remove<0x1::string::String, vector<u8>>(v0, &arg2);
            };
        } else if (0x2::vec_map::contains<0x1::string::String, vector<u8>>(v0, &arg2)) {
            *0x2::vec_map::get_mut<0x1::string::String, vector<u8>>(v0, &arg2) = arg3;
        } else {
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(v0, arg2, arg3);
        };
    }

    public fun set_symbol_max_confidence_bps(arg0: &mut Config, arg1: &0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::ListingCap, arg2: 0x1::string::String, arg3: u64) {
        let v0 = borrow_max_conf_config_mut(arg0);
        if (0x2::vec_map::contains<0x1::string::String, u64>(&v0.by_symbol, &arg2)) {
            *0x2::vec_map::get_mut<0x1::string::String, u64>(&mut v0.by_symbol, &arg2) = arg3;
        } else {
            0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.by_symbol, arg2, arg3);
        };
    }

    public fun set_tolerance_sec(arg0: &mut Config, arg1: &0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::ListingCap, arg2: 0x1::string::String, arg3: u64) {
        if (arg3 == 0) {
            err_invalid_tolerance();
        };
        let v0 = &mut arg0.tolerance_sec_map;
        if (0x2::vec_map::contains<0x1::string::String, u64>(v0, &arg2)) {
            *0x2::vec_map::get_mut<0x1::string::String, u64>(v0, &arg2) = arg3;
        } else {
            0x2::vec_map::insert<0x1::string::String, u64>(v0, arg2, arg3);
        };
    }

    public fun unset_symbol_max_confidence_bps(arg0: &mut Config, arg1: &0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::ListingCap, arg2: 0x1::string::String) {
        let v0 = MaxConfBpsKey{dummy_field: false};
        if (0x2::dynamic_field::exists<MaxConfBpsKey>(&arg0.id, v0)) {
            let v1 = MaxConfBpsKey{dummy_field: false};
            let v2 = 0x2::dynamic_field::borrow_mut<MaxConfBpsKey, MaxConfBpsConfig>(&mut arg0.id, v1);
            if (0x2::vec_map::contains<0x1::string::String, u64>(&v2.by_symbol, &arg2)) {
                let (_, _) = 0x2::vec_map::remove<0x1::string::String, u64>(&mut v2.by_symbol, &arg2);
            };
        };
    }

    // decompiled from Move bytecode v7
}

