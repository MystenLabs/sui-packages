module 0x695e2e8629657add44ff0ac69f0ff7b68b050276134d1b5a4ef0315fe9fa935e::reader {
    public fun current<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: &0x695e2e8629657add44ff0ac69f0ff7b68b050276134d1b5a4ef0315fe9fa935e::anchor_config::Config, arg4: bool) : vector<u128> {
        0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::validate_pool_version<T0>(arg0);
        let v0 = 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg0);
        let v1 = 0x2::object::id_to_address(&v0) == @0x21167b2e981e2c0a693afcfe882a3a827d663118e19afcb92e45bfe43fe56278;
        let v2 = b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI";
        let v3 = b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC";
        let v4 = if (v1) {
            v2
        } else {
            v3
        };
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())) == v4, 1201);
        let v5 = if (v1) {
            v3
        } else {
            v2
        };
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>())) == v5, 1201);
        let v6 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_pool_detailed_info<T0>(arg0);
        let v7 = 0x2::bcs::new(0x1::bcs::to_bytes<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::PoolDetailedInfo<T0>>(&v6));
        0x2::bcs::peel_address(&mut v7);
        0x2::bcs::peel_u64(&mut v7);
        0x2::bcs::peel_address(&mut v7);
        0x2::bcs::peel_u64(&mut v7);
        0x2::bcs::peel_u64(&mut v7);
        0x2::bcs::peel_vec_vec_u8(&mut v7);
        let v8 = 0;
        let v9 = 0;
        let v10 = false;
        while (v8 < 0x2::bcs::peel_vec_length(&mut v7)) {
            if (0x2::bcs::peel_vec_u8(&mut v7) == 0x2::bcs::peel_vec_u8(&mut v7)) {
                v9 = 0x2::bcs::peel_u128(&mut v7);
                v10 = true;
            };
            v8 = v8 + 1;
        };
        let v11 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_quote_asset_info<T0, T1>(arg0);
        let v12 = 0x2::bcs::new(0x1::bcs::to_bytes<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::QuoteAssetInfo>(&v11));
        0x2::bcs::peel_vec_u8(&mut v12);
        let v13 = 0x2::bcs::peel_option_u64(&mut v12);
        let v14 = 0x2::bcs::peel_option_u64(&mut v12);
        let v15 = 0x2::bcs::into_remainder_bytes(v12);
        assert!(0x1::vector::is_empty<u8>(&v15), 1202);
        let v16 = if (arg4) {
            let (v17, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::get_valid_price<T1, T0>(arg1, arg2);
            v17
        } else {
            let (v19, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::get_valid_price<T0, T1>(arg1, arg2);
            v19
        };
        let v21 = v16;
        let v22 = 0x2::bcs::new(0x1::bcs::to_bytes<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::PriceData>(&v21));
        let v23 = if (arg4) {
            0x2::bcs::peel_u64(&mut v12)
        } else {
            0x2::bcs::peel_u64(&mut v7)
        };
        let v24 = if (!0x2::bcs::peel_bool(&mut v7)) {
            if (0x2::bcs::peel_bool(&mut v12)) {
                v10
            } else {
                false
            }
        } else {
            false
        };
        0x695e2e8629657add44ff0ac69f0ff7b68b050276134d1b5a4ef0315fe9fa935e::curve::prepare(0x2::bcs::peel_u128(&mut v22), 0x695e2e8629657add44ff0ac69f0ff7b68b050276134d1b5a4ef0315fe9fa935e::anchor_config::anchor(arg3, v0), 0x2::bcs::peel_u64(&mut v12), 0x2::bcs::peel_u64(&mut v12), 0x1::option::get_with_default<u64>(&v13, 0x2::bcs::peel_u64(&mut v7)), 0x1::option::get_with_default<u64>(&v14, 18446744073709551615), 0x2::bcs::peel_u64(&mut v7), 0x2::bcs::peel_u64(&mut v12), 0x2::bcs::peel_u64(&mut v12), 0x2::bcs::peel_u64(&mut v12), 0x2::bcs::peel_u64(&mut v7), 0x2::bcs::peel_u64(&mut v7), v23, arg4, v24, 0x2::bcs::peel_u64(&mut v7), 0x2::bcs::peel_u64(&mut v7), v9)
    }

    // decompiled from Move bytecode v7
}

