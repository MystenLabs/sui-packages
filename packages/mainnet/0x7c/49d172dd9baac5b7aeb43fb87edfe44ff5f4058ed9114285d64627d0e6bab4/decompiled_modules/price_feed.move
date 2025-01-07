module 0x7c49d172dd9baac5b7aeb43fb87edfe44ff5f4058ed9114285d64627d0e6bab4::price_feed {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct SupraConfig has key {
        id: 0x2::object::UID,
        index_map: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u32>,
    }

    public fun add_coin_type<T0>(arg0: &0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::listing::ListingCap, arg1: &mut SupraConfig, arg2: u32) {
        0x2::vec_map::insert<0x1::type_name::TypeName, u32>(&mut arg1.index_map, 0x1::type_name::get<T0>(), arg2);
    }

    public fun borrow_index_map(arg0: &SupraConfig) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u32> {
        &arg0.index_map
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SupraConfig{
            id        : 0x2::object::new(arg0),
            index_map : 0x2::vec_map::empty<0x1::type_name::TypeName, u32>(),
        };
        0x2::transfer::share_object<SupraConfig>(v0);
    }

    public fun remove_coin_type<T0>(arg0: &0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::listing::ListingCap, arg1: &mut SupraConfig) {
        let v0 = 0x1::type_name::get<T0>();
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u32>(&mut arg1.index_map, &v0);
    }

    public fun update_cny_oracle<T0>(arg0: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::oracle::Oracle, arg1: &0x2::clock::Clock, arg2: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg3: &SupraConfig) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u32>(&arg3.index_map, &v0), 0);
        let v1 = *0x2::vec_map::get<0x1::type_name::TypeName, u32>(&arg3.index_map, &v0);
        let (v2, v3, v4, _) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg2, v1);
        assert!(0x2::clock::timestamp_ms(arg1) - (v4 as u64) <= 300000, 1);
        let v6 = if (v1 == 90) {
            0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::oracle::precision() * (0x2::math::pow(10, (v3 as u8)) as u128) / v2
        } else {
            0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::oracle::precision() * v2 / (0x2::math::pow(10, (v3 as u8)) as u128)
        };
        let v7 = Rule{dummy_field: false};
        0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::oracle::update_price<T0, Rule>(v7, arg0, arg1, v6);
    }

    // decompiled from Move bytecode v6
}

