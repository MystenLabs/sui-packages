module 0xba3c970933047c6e235424d7040a9a4e89d8fc1200d780a69b2666434f3a7313::gcoin_rule {
    struct GCoinRule has drop {
        dummy_field: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        underlying_coin_map: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1::type_name::TypeName>,
    }

    public fun add_gcoin_pair<T0, T1>(arg0: &mut Config, arg1: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::listing::ListingCap) {
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

    fun err_unsupported_gcoin_type() {
        abort 1
    }

    public fun feed<T0, T1>(arg0: &mut 0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::collector::PriceCollector<T0>, arg1: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T1>, arg2: &Config, arg3: &0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg2.underlying_coin_map, &v0)) {
            err_unsupported_gcoin_type();
        };
        let v1 = 0x1::type_name::get<T1>();
        if (&v1 != 0x2::vec_map::get<0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg2.underlying_coin_map, &v0)) {
            err_invalid_coin_type();
        };
        let (v2, _, v4, _, v6, _) = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::house_metadata<T1>(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::borrow_house<T1>(arg3));
        let v8 = GCoinRule{dummy_field: false};
        0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::collector::collect<T0, GCoinRule>(arg0, v8, 0x1::option::some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::aggregated_price<T1>(arg1), v2 + v6), v4)));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                  : 0x2::object::new(arg0),
            underlying_coin_map : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x1::type_name::TypeName>(),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun remove_gcoin_pair<T0>(arg0: &mut Config, arg1: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::listing::ListingCap) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x1::type_name::TypeName>(&arg0.underlying_coin_map, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x1::type_name::TypeName>(&mut arg0.underlying_coin_map, &v0);
        };
    }

    // decompiled from Move bytecode v6
}

