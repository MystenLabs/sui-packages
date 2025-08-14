module 0x855e2f7810fd7acbd470def555c3909ecd72e8dd3bf2989e4c223a455dd1bb33::pyth_rule {
    struct PythRule has drop {
        dummy_field: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        identifier_map: 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<u8>>,
    }

    fun err_invalid_price_info_object() {
        abort 1
    }

    fun err_unsupported_coin_type() {
        abort 0
    }

    public fun feed<T0>(arg0: &mut 0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::collector::PriceCollector<T0>, arg1: &Config, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, vector<u8>>(&arg1.identifier_map, &v0)) {
            err_unsupported_coin_type();
        };
        if (0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg4) != 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_price_info_object_id(arg3, *0x2::vec_map::get<0x1::type_name::TypeName, vector<u8>>(&arg1.identifier_map, &v0))) {
            err_invalid_price_info_object();
        };
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price(arg3, arg4, arg2);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v1);
        let v4 = PythRule{dummy_field: false};
        0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::collector::collect<T0, PythRule>(arg0, v4, 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::from_fraction(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v2), 0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v3) as u8))));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id             : 0x2::object::new(arg0),
            identifier_map : 0x2::vec_map::empty<0x1::type_name::TypeName, vector<u8>>(),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun set_identifier<T0>(arg0: &mut Config, arg1: &0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::listing::ListingCap, arg2: vector<u8>) {
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

    // decompiled from Move bytecode v6
}

