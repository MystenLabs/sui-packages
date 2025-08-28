module 0x18f4f3cd05ab7ff6dc0c41c692e3caae925927cc096f1de3de81d85a89f87aca::scoin_rule {
    struct SCoinRule has drop {
        dummy_field: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        underlying_coin_map: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1::type_name::TypeName>,
    }

    public fun add_scoin_pair<T0, T1>(arg0: &mut Config, arg1: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::listing::ListingCap) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg0.underlying_coin_map, &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x1::type_name::TypeName>(&mut arg0.underlying_coin_map, &v0) = 0x1::type_name::get<T1>();
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, 0x1::type_name::TypeName>(&mut arg0.underlying_coin_map, v0, 0x1::type_name::get<T1>());
        };
    }

    fun err_invalid_coin_type() {
        abort 2
    }

    fun err_unsupported_scoin_type() {
        abort 1
    }

    public fun feed<T0, T1>(arg0: &mut 0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::collector::PriceCollector<T0>, arg1: &Config, arg2: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T1>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg1.underlying_coin_map, &v0)) {
            err_unsupported_scoin_type();
        };
        let v1 = 0x1::type_name::get<T1>();
        if (&v1 != 0x2::vec_map::get<0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg1.underlying_coin_map, &v0)) {
            err_invalid_coin_type();
        };
        let v2 = SCoinRule{dummy_field: false};
        0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::collector::collect<T0, SCoinRule>(arg0, v2, 0x1::option::some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div(0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::aggregated_price<T1>(arg2), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_scaled_val((0x18f4f3cd05ab7ff6dc0c41c692e3caae925927cc096f1de3de81d85a89f87aca::utils::calc_coin_to_scoin(arg3, arg4, v1, arg5, (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::precision() as u64)) as u128)))));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                  : 0x2::object::new(arg0),
            underlying_coin_map : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x1::type_name::TypeName>(),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun remove_scoin_pair<T0>(arg0: &mut Config, arg1: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::listing::ListingCap) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg0.underlying_coin_map, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x1::type_name::TypeName>(&mut arg0.underlying_coin_map, &v0);
        };
    }

    // decompiled from Move bytecode v6
}

