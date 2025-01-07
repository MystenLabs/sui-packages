module 0x5b3cc8379f5bab1ede9a562c47de1d12fb8c291772f5965ece9b76ecb0e72f02::price_feed {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct PriceInfo has copy, drop, store {
        reciprocal: bool,
        supra_index: u32,
    }

    struct SupraConfig has key {
        id: 0x2::object::UID,
        index_map: 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<PriceInfo>>,
    }

    public fun add_coin_type<T0>(arg0: &0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::listing::ListingCap, arg1: &mut SupraConfig, arg2: vector<bool>, arg3: vector<u32>) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<PriceInfo>();
        while (v0 < 0x1::vector::length<bool>(&arg2)) {
            let v2 = PriceInfo{
                reciprocal  : *0x1::vector::borrow<bool>(&arg2, v0),
                supra_index : *0x1::vector::borrow<u32>(&arg3, v0),
            };
            0x1::vector::push_back<PriceInfo>(&mut v1, v2);
            v0 = v0 + 1;
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, vector<PriceInfo>>(&mut arg1.index_map, 0x1::type_name::get<T0>(), v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SupraConfig{
            id        : 0x2::object::new(arg0),
            index_map : 0x2::vec_map::empty<0x1::type_name::TypeName, vector<PriceInfo>>(),
        };
        0x2::transfer::share_object<SupraConfig>(v0);
    }

    public fun remove_coin_type<T0>(arg0: &0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::listing::ListingCap, arg1: &mut SupraConfig) {
        let v0 = 0x1::type_name::get<T0>();
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, vector<PriceInfo>>(&mut arg1.index_map, &v0);
    }

    public fun update_cny_oracle<T0>(arg0: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::oracle::Oracle, arg1: &0x2::clock::Clock, arg2: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg3: &SupraConfig) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, vector<PriceInfo>>(&arg3.index_map, &v0), 0);
        let v1 = 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::oracle::precision();
        let v2 = *0x2::vec_map::get<0x1::type_name::TypeName, vector<PriceInfo>>(&arg3.index_map, &v0);
        let v3 = 0;
        while (v3 < 0x1::vector::length<PriceInfo>(&v2)) {
            let v4 = 0x1::vector::borrow<PriceInfo>(&v2, v3);
            let (_, _, v7, _) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg2, v4.supra_index);
            assert!(0x2::clock::timestamp_ms(arg1) - (v7 as u64) <= 300000, 1);
            if (v4.reciprocal) {
            };
            v3 = v3 + 1;
        };
        let v9 = Rule{dummy_field: false};
        0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::oracle::update_price<T0, Rule>(v9, arg0, arg1, v1);
    }

    // decompiled from Move bytecode v6
}

