module 0x928ff0be132d9bad7926008780d2a5adfefa1a24559a567dafbfd267d1b1b294::af_lp_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    fun exp_decimals(arg0: u8) : u64 {
        0x2::math::pow(10, arg0)
    }

    fun get_first_two_elements<T0: copy>(arg0: &vector<T0>) : (T0, T0) {
        assert!(0x1::vector::length<T0>(arg0) == 2, 1);
        (*0x1::vector::borrow<T0>(arg0, 0), *0x1::vector::borrow<T0>(arg0, 1))
    }

    public fun lp_price<T0, T1, T2>(arg0: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::type_names<T0>(arg1);
        let (v1, v2) = get_first_two_elements<0x1::ascii::String>(&v0);
        assert!(v1 == 0x1::type_name::into_string(0x1::type_name::get<T1>()), 0);
        assert!(v2 == 0x1::type_name::into_string(0x1::type_name::get<T2>()), 0);
        let v3 = *0x1::option::borrow<vector<u8>>(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::coin_decimals<T0>(arg1));
        let (v4, v5) = get_first_two_elements<u8>(&v3);
        let v6 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_all_coin_withdraw<T0>(arg1, exp_decimals(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::lp_decimals<T0>(arg1)));
        let (v7, v8) = get_first_two_elements<u64>(&v6);
        let (v9, v10) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<T1>(arg0, arg2);
        let (v11, v12) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<T2>(arg0, arg2);
        let v13 = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::precision<T0>(0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::borrow_single_oracle<T0>(arg0));
        mul_and_div(mul_and_div(v9, v13, v10), v7, exp_decimals(v4)) + mul_and_div(mul_and_div(v11, v13, v12), v8, exp_decimals(v5))
    }

    fun mul_and_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun update_price<T0, T1, T2>(arg0: &mut 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg2: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::update_oracle_price_with_rule<T0, Rule>(0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::borrow_single_oracle_mut<T0>(arg0), v0, arg2, lp_price<T0, T1, T2>(arg0, arg1, arg2));
    }

    // decompiled from Move bytecode v6
}

