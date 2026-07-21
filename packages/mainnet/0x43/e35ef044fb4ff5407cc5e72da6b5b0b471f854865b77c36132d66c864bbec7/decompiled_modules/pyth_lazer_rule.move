module 0x43e35ef044fb4ff5407cc5e72da6b5b0b471f854865b77c36132d66c864bbec7::pyth_lazer_rule {
    struct PythLazerRule has drop {
        dummy_field: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        feed_id_map: 0x2::vec_map::VecMap<0x1::string::String, u32>,
        tolerance_ms_map: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    struct MaxConfBpsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MaxConfBpsConfig has store {
        default_bps: u64,
        by_symbol: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    struct LazerFeedIdSet has copy, drop {
        symbol: 0x1::string::String,
        feed_id: 0x1::option::Option<u32>,
    }

    struct LazerToleranceSet has copy, drop {
        symbol: 0x1::string::String,
        tolerance_ms: u64,
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

    public fun feed(arg0: &mut 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::PriceCollector, arg1: &Config, arg2: &0x2::clock::Clock, arg3: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update) {
        let v0 = 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::symbol(arg0);
        if (!0x2::vec_map::contains<0x1::string::String, u32>(&arg1.feed_id_map, &v0)) {
            let v1 = PythLazerRule{dummy_field: false};
            0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::collect<PythLazerRule>(arg0, v1, 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>());
            return
        };
        let v2 = find_feed(arg3, *0x2::vec_map::get<0x1::string::String, u32>(&arg1.feed_id_map, &v0));
        let v3 = if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&v2)) {
            0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>()
        } else {
            let v4 = 0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v2);
            let v5 = 0x2::vec_map::try_get<0x1::string::String, u64>(&arg1.tolerance_ms_map, &v0);
            let v6 = if (0x1::option::is_some<u64>(&v5)) {
                0x1::option::destroy_some<u64>(v5)
            } else {
                0x1::option::destroy_none<u64>(v5);
                5000
            };
            if (is_fresh(0x2::clock::timestamp_ms(arg2), 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg3), v6)) {
                price_or_abstain(&v4, arg1, &v0)
            } else {
                0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>()
            }
        };
        let v7 = PythLazerRule{dummy_field: false};
        0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::collect<PythLazerRule>(arg0, v7, v3);
    }

    public fun feed_id(arg0: &Config, arg1: 0x1::string::String) : 0x1::option::Option<u32> {
        if (0x2::vec_map::contains<0x1::string::String, u32>(&arg0.feed_id_map, &arg1)) {
            0x1::option::some<u32>(*0x2::vec_map::get<0x1::string::String, u32>(&arg0.feed_id_map, &arg1))
        } else {
            0x1::option::none<u32>()
        }
    }

    fun find_feed(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg1: u32) : 0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed> {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds_ref(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v0)) {
            let v2 = 0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v0, v1);
            if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(v2) == arg1) {
                return 0x1::option::some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(*v2)
            };
            v1 = v1 + 1;
        };
        0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>()
    }

    fun flatten_i64_positive(arg0: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>) : 0x1::option::Option<u64> {
        if (0x1::option::is_none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&arg0)) {
            return 0x1::option::none<u64>()
        };
        let v0 = 0x1::option::destroy_some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(arg0);
        if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v0)) {
            return 0x1::option::none<u64>()
        };
        let v1 = 0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(v0);
        if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v1)) {
            return 0x1::option::none<u64>()
        };
        let v2 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v1);
        if (v2 == 0) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>(v2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id               : 0x2::object::new(arg0),
            feed_id_map      : 0x2::vec_map::empty<0x1::string::String, u32>(),
            tolerance_ms_map : 0x2::vec_map::empty<0x1::string::String, u64>(),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    fun is_fresh(arg0: u64, arg1: u64, arg2: u64) : bool {
        0x1::u64::diff(arg0, arg1 / 1000) <= arg2
    }

    public fun max_confidence_bps(arg0: &Config, arg1: 0x1::string::String) : u64 {
        resolve_max_confidence_bps(arg0, &arg1)
    }

    fun price_or_abstain(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed, arg1: &Config, arg2: &0x1::string::String) : 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float> {
        let v0 = flatten_i64_positive(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::price(arg0));
        if (0x1::option::is_none<u64>(&v0)) {
            return 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>()
        };
        let v1 = 0x1::option::destroy_some<u64>(v0);
        let v2 = flatten_i64_positive(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::confidence(arg0));
        if (0x1::option::is_some<u64>(&v2)) {
            if (!confidence_ok(v1, 0x1::option::destroy_some<u64>(v2), resolve_max_confidence_bps(arg1, arg2))) {
                return 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>()
            };
        };
        let v3 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::exponent(arg0);
        if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&v3)) {
            return 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>()
        };
        let v4 = 0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(v3);
        if (!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&v4)) {
            return 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>()
        };
        let v5 = (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v4) as u64);
        if (v5 > 18) {
            return 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>()
        };
        0x1::option::some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_fraction(v1, 0x1::u64::pow(10, (v5 as u8))))
    }

    public fun remove_feed_id(arg0: &mut Config, arg1: &0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::ListingCap, arg2: 0x1::string::String) {
        let v0 = &mut arg0.feed_id_map;
        if (0x2::vec_map::contains<0x1::string::String, u32>(v0, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, u32>(v0, &arg2);
            let v3 = LazerFeedIdSet{
                symbol  : arg2,
                feed_id : 0x1::option::none<u32>(),
            };
            0x2::event::emit<LazerFeedIdSet>(v3);
        };
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

    public fun set_feed_id(arg0: &mut Config, arg1: &0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::ListingCap, arg2: 0x1::string::String, arg3: u32) {
        let v0 = &mut arg0.feed_id_map;
        if (0x2::vec_map::contains<0x1::string::String, u32>(v0, &arg2)) {
            *0x2::vec_map::get_mut<0x1::string::String, u32>(v0, &arg2) = arg3;
        } else {
            0x2::vec_map::insert<0x1::string::String, u32>(v0, arg2, arg3);
        };
        let v1 = LazerFeedIdSet{
            symbol  : arg2,
            feed_id : 0x1::option::some<u32>(arg3),
        };
        0x2::event::emit<LazerFeedIdSet>(v1);
    }

    public fun set_symbol_max_confidence_bps(arg0: &mut Config, arg1: &0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::ListingCap, arg2: 0x1::string::String, arg3: u64) {
        let v0 = borrow_max_conf_config_mut(arg0);
        if (0x2::vec_map::contains<0x1::string::String, u64>(&v0.by_symbol, &arg2)) {
            *0x2::vec_map::get_mut<0x1::string::String, u64>(&mut v0.by_symbol, &arg2) = arg3;
        } else {
            0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.by_symbol, arg2, arg3);
        };
    }

    public fun set_tolerance_ms(arg0: &mut Config, arg1: &0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::ListingCap, arg2: 0x1::string::String, arg3: u64) {
        if (arg3 == 0) {
            abort 13906835553028145157
        };
        let v0 = &mut arg0.tolerance_ms_map;
        if (0x2::vec_map::contains<0x1::string::String, u64>(v0, &arg2)) {
            *0x2::vec_map::get_mut<0x1::string::String, u64>(v0, &arg2) = arg3;
        } else {
            0x2::vec_map::insert<0x1::string::String, u64>(v0, arg2, arg3);
        };
        let v1 = LazerToleranceSet{
            symbol       : arg2,
            tolerance_ms : arg3,
        };
        0x2::event::emit<LazerToleranceSet>(v1);
    }

    public fun tolerance_ms(arg0: &Config, arg1: 0x1::string::String) : u64 {
        let v0 = 0x2::vec_map::try_get<0x1::string::String, u64>(&arg0.tolerance_ms_map, &arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            0x1::option::destroy_some<u64>(v0)
        } else {
            0x1::option::destroy_none<u64>(v0);
            5000
        }
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

