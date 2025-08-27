module 0x6ee87742e673749a97f5fbe576b92d8dd294a482307d3a3fb2c6f73a56b906a0::pyth_rule {
    struct PythRule has drop {
        dummy_field: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        identifier_map: 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<u8>>,
        tolerance_sec_map: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    fun err_invalid_price_info_object() {
        abort 1
    }

    fun err_invalid_tolerance_settings() {
        abort 2
    }

    fun err_unsupported_coin_type() {
        abort 0
    }

    public fun feed<T0>(arg0: &mut 0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::collector::PriceCollector<T0>, arg1: &Config, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, vector<u8>>(&arg1.identifier_map, &v0)) {
            err_unsupported_coin_type();
        };
        if (0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg4) != 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_price_info_object_id(arg3, *0x2::vec_map::get<0x1::type_name::TypeName, vector<u8>>(&arg1.identifier_map, &v0))) {
            err_invalid_price_info_object();
        };
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg4);
        let v2 = if (0x2::clock::timestamp_ms(arg2) / 1000 - 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v1) <= 0x1::option::destroy_with_default<u64>(0x2::vec_map::try_get<0x1::type_name::TypeName, u64>(&arg1.tolerance_sec_map, &v0), 30)) {
            let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v1);
            let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v1);
            0x1::option::some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_fraction(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3), 0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v4) as u8))))
        } else {
            0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>()
        };
        let v5 = PythRule{dummy_field: false};
        0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::collector::collect<T0, PythRule>(arg0, v5, v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                : 0x2::object::new(arg0),
            identifier_map    : 0x2::vec_map::empty<0x1::type_name::TypeName, vector<u8>>(),
            tolerance_sec_map : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun set_identifier<T0>(arg0: &mut Config, arg1: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::listing::ListingCap, arg2: vector<u8>) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = &mut arg0.identifier_map;
        if (0x1::vector::is_empty<u8>(&arg2)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, vector<u8>>(v1, &v0);
        } else if (0x2::vec_map::contains<0x1::type_name::TypeName, vector<u8>>(v1, &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, vector<u8>>(v1, &v0) = arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, vector<u8>>(v1, v0, arg2);
        };
    }

    public fun set_tolerance_sec<T0>(arg0: &mut Config, arg1: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::listing::ListingCap, arg2: u64) {
        if (arg2 > 30) {
            err_invalid_tolerance_settings();
        };
        let v0 = 0x1::type_name::get<T0>();
        let v1 = &mut arg0.tolerance_sec_map;
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(v1, &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(v1, &v0) = arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(v1, v0, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

