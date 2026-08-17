module 0x50a859ff33f5d82bc131f21b8a544a1e48cd61c88652f65c5ce7c6a6b091f98::supra_rule {
    struct SupraRule has drop {
        dummy_field: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        pair_id_map: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u32>,
        tolerance_ms_map: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct PairIdUpdated has copy, drop {
        coin_type: 0x1::ascii::String,
        pair_id: 0x1::option::Option<u32>,
    }

    struct ToleranceUpdated has copy, drop {
        coin_type: 0x1::ascii::String,
        tolerance_ms: u64,
    }

    fun err_invalid_tolerance() {
        abort 1
    }

    fun err_unsupported_coin_type() {
        abort 0
    }

    public fun feed<T0>(arg0: &mut 0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::collector::PriceCollector<T0>, arg1: &Config, arg2: &0x2::clock::Clock, arg3: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u32>(&arg1.pair_id_map, &v0)) {
            err_unsupported_coin_type();
        };
        let (v1, v2, v3, _) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg3, *0x2::vec_map::get<0x1::type_name::TypeName, u32>(&arg1.pair_id_map, &v0));
        let v5 = 0x2::vec_map::try_get<0x1::type_name::TypeName, u64>(&arg1.tolerance_ms_map, &v0);
        let v6 = if (0x1::option::is_some<u64>(&v5)) {
            0x1::option::destroy_some<u64>(v5)
        } else {
            0x1::option::destroy_none<u64>(v5);
            30000
        };
        let v7 = if (is_fresh(0x2::clock::timestamp_ms(arg2), v3, v6)) {
            to_float(v1, v2)
        } else {
            0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>()
        };
        let v8 = SupraRule{dummy_field: false};
        0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::collector::collect<T0, SupraRule>(arg0, v8, v7);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id               : 0x2::object::new(arg0),
            pair_id_map      : 0x2::vec_map::empty<0x1::type_name::TypeName, u32>(),
            tolerance_ms_map : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    fun is_fresh(arg0: u64, arg1: u128, arg2: u64) : bool {
        0x1::u128::diff((arg0 as u128), arg1) <= (arg2 as u128)
    }

    public fun pair_id<T0>(arg0: &Config) : 0x1::option::Option<u32> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_map::try_get<0x1::type_name::TypeName, u32>(&arg0.pair_id_map, &v0)
    }

    public fun remove_pair_id<T0>(arg0: &mut Config, arg1: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::listing::ListingCap) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = &mut arg0.pair_id_map;
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u32>(v1, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u32>(v1, &v0);
            let v4 = PairIdUpdated{
                coin_type : 0x1::type_name::into_string(v0),
                pair_id   : 0x1::option::none<u32>(),
            };
            0x2::event::emit<PairIdUpdated>(v4);
        };
    }

    public fun set_pair_id<T0>(arg0: &mut Config, arg1: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::listing::ListingCap, arg2: u32) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = &mut arg0.pair_id_map;
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u32>(v1, &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u32>(v1, &v0) = arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u32>(v1, v0, arg2);
        };
        let v2 = PairIdUpdated{
            coin_type : 0x1::type_name::into_string(v0),
            pair_id   : 0x1::option::some<u32>(arg2),
        };
        0x2::event::emit<PairIdUpdated>(v2);
    }

    public fun set_tolerance_ms<T0>(arg0: &mut Config, arg1: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::listing::ListingCap, arg2: u64) {
        if (arg2 == 0) {
            err_invalid_tolerance();
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = &mut arg0.tolerance_ms_map;
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(v1, &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(v1, &v0) = arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(v1, v0, arg2);
        };
        let v2 = ToleranceUpdated{
            coin_type    : 0x1::type_name::into_string(v0),
            tolerance_ms : arg2,
        };
        0x2::event::emit<ToleranceUpdated>(v2);
    }

    fun to_float(arg0: u128, arg1: u16) : 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float> {
        if (arg0 == 0) {
            return 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>()
        };
        if (arg1 > 38) {
            return 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>()
        };
        let v0 = 9;
        let v1 = if (arg1 >= v0) {
            arg0 / 0x1::u128::pow(10, ((arg1 - v0) as u8))
        } else {
            let v2 = 0x1::u128::pow(10, ((v0 - arg1) as u8));
            if (arg0 > 340282366920938463463374607431768211455 / v2) {
                return 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>()
            };
            arg0 * v2
        };
        if (v1 == 0) {
            return 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>()
        };
        if (v1 > 18446744073709551615 * 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::precision()) {
            return 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>()
        };
        0x1::option::some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_scaled_val(v1))
    }

    public fun tolerance_ms<T0>(arg0: &Config) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::vec_map::try_get<0x1::type_name::TypeName, u64>(&arg0.tolerance_ms_map, &v0);
        if (0x1::option::is_some<u64>(&v1)) {
            0x1::option::destroy_some<u64>(v1)
        } else {
            0x1::option::destroy_none<u64>(v1);
            30000
        }
    }

    // decompiled from Move bytecode v7
}

