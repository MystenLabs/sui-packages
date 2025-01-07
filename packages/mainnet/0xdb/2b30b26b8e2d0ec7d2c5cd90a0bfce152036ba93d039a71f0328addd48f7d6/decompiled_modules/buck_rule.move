module 0xdb2b30b26b8e2d0ec7d2c5cd90a0bfce152036ba93d039a71f0328addd48f7d6::buck_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct StableTypes has key {
        id: 0x2::object::UID,
        types: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    fun get_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price(arg0, arg1, arg2);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v2))
    }

    public fun add_stable_type<T0>(arg0: &0x80fe74322a141e1a4de653c7ed7f8341c457fb91c7415347ba5475cda8c40faf::listing::ListingCap, arg1: &mut StableTypes) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.types, 0x1::type_name::get<T0>());
    }

    fun err_invalid_price_info_object() {
        abort 0
    }

    fun err_invalid_stable_type() {
        abort 1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StableTypes{
            id    : 0x2::object::new(arg0),
            types : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x2::transfer::share_object<StableTypes>(v0);
    }

    public fun is_stable_type<T0>(arg0: &StableTypes) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.types, &v0)
    }

    public fun remove_stable_type<T0>(arg0: &0x80fe74322a141e1a4de653c7ed7f8341c457fb91c7415347ba5475cda8c40faf::listing::ListingCap, arg1: &mut StableTypes) {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg1.types, &v0);
    }

    public fun update_blast_off_oracle<T0>(arg0: &mut 0x80fe74322a141e1a4de653c7ed7f8341c457fb91c7415347ba5475cda8c40faf::oracle::Oracle, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &StableTypes) {
        if (!is_stable_type<T0>(arg4)) {
            err_invalid_stable_type();
        };
        if (0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg3) != 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_price_info_object_id(arg2, x"23d7315113f5b1d3ba7a83604c44b94d79f4fd69af77f804fc7f920a6dc65744")) {
            err_invalid_price_info_object();
        };
        let (v0, v1) = get_price(arg2, arg3, arg1);
        let v2 = Rule{dummy_field: false};
        0x80fe74322a141e1a4de653c7ed7f8341c457fb91c7415347ba5475cda8c40faf::oracle::update_price<T0, Rule>(v2, arg0, arg1, 0x80fe74322a141e1a4de653c7ed7f8341c457fb91c7415347ba5475cda8c40faf::config::precision() * (0x2::math::pow(10, (v1 as u8)) as u128) / (v0 as u128) * 10 / 9);
    }

    // decompiled from Move bytecode v6
}

