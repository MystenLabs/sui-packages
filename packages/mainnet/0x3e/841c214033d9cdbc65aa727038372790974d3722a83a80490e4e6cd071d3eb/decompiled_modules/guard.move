module 0xe1b9fbd9b9de70a494d4ec4aa487ccd24dc926a2ab0060b0bcea116e8ea3db9a::guard {
    public fun assert_2pool_bf_mmt_v1<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u128, arg2: bool, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg4: u128, arg5: bool) {
        assert_bluefin<T0, T1>(arg0, arg1, arg2);
        assert_mmt<T2, T3>(arg3, arg4, arg5);
    }

    public fun assert_2pool_cetus_bf<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: bool, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg4: u128, arg5: bool) {
        assert_cetus<T0, T1>(arg0, arg1, arg2);
        assert_bluefin<T2, T3>(arg3, arg4, arg5);
    }

    public fun assert_2pool_cetus_cetus<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: bool, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: u128, arg5: bool) {
        assert_cetus<T0, T1>(arg0, arg1, arg2);
        assert_cetus<T2, T3>(arg3, arg4, arg5);
    }

    public fun assert_2pool_cetus_mmt_v1<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: bool, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg4: u128, arg5: bool) {
        assert_cetus<T0, T1>(arg0, arg1, arg2);
        assert_mmt<T2, T3>(arg3, arg4, arg5);
    }

    public fun assert_aftermath_ratio(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: &0x2::clock::Clock, arg5: u64) {
        assert_clock_deadline(arg4, arg5);
        assert_ratio_x1e9(arg0, arg1, arg2, arg3);
    }

    public fun assert_bluefin<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        assert_sqrt(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0), arg1, arg2);
    }

    public fun assert_bm_min_balance<T0>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: u64) {
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg0) >= arg1, 2003);
    }

    public fun assert_bolt_not_expired<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg1: &0x2::clock::Clock, arg2: u64) {
        assert_clock_deadline(arg1, arg2);
        let (_, v1) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::get_valid_price<T0, T1>(arg0, arg1);
        assert!(v1, 2002);
    }

    public fun assert_bounds_u128(arg0: u128, arg1: u128, arg2: u128) {
        assert!(arg0 >= arg1 && arg0 <= arg2, 2001);
    }

    public fun assert_bounds_u32(arg0: u32, arg1: u32, arg2: u32) {
        assert!(arg0 >= arg1 && arg0 <= arg2, 2001);
    }

    public fun assert_cetus<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        assert_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0), arg1, arg2);
    }

    public fun assert_cetus_dlmm<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: u32, arg2: u32, arg3: &0x2::clock::Clock, arg4: u64) {
        assert_clock_deadline(arg3, arg4);
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg0);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1)) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2)), 2001);
    }

    public fun assert_clock_deadline(arg0: &0x2::clock::Clock, arg1: u64) {
        if (arg1 > 0) {
            assert!(0x2::clock::timestamp_ms(arg0) <= arg1, 2002);
        };
    }

    public fun assert_deepbook_mid<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64, arg3: bool) {
        if (arg3) {
            assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg0, arg1) >= arg2, 2002);
        } else {
            assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg0, arg1) <= arg2, 2002);
        };
    }

    public fun assert_deepbook_mid_band<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg0, arg1);
        assert!(v0 >= arg2 && v0 <= arg3, 2002);
    }

    public fun assert_dipcoin_ratio(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: &0x2::clock::Clock, arg5: u64) {
        assert_clock_deadline(arg4, arg5);
        assert_ratio_x1e9(arg0, arg1, arg2, arg3);
    }

    public fun assert_ferra_dlmm_active_id<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: u32, arg2: u32, arg3: &0x2::clock::Clock, arg4: u64) {
        assert_clock_deadline(arg3, arg4);
        assert_bounds_u32(0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_active_id<T0, T1>(arg0), arg1, arg2);
    }

    public fun assert_flowx<T0, T1>(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: u128, arg2: u128, arg3: &0x2::clock::Clock, arg4: u64) {
        assert_clock_deadline(arg3, arg4);
        assert_bounds_u128(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, T1>(arg0), arg1, arg2);
    }

    public fun assert_flowx_v2<T0, T1>(arg0: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg1: u128, arg2: u128, arg3: &0x2::clock::Clock, arg4: u64) {
        assert_clock_deadline(arg3, arg4);
        let (v0, v1) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_reserves<T0, T1>(arg0);
        assert_ratio_x1e9(v0, v1, arg1, arg2);
    }

    public fun assert_flowx_v2_pair<T0, T1>(arg0: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: u128, arg2: u128, arg3: &0x2::clock::Clock, arg4: u64) {
        assert_clock_deadline(arg3, arg4);
        let (v0, v1) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_reserves<T0, T1>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_pair<T0, T1>(arg0));
        assert_ratio_x1e9(v0, v1, arg1, arg2);
    }

    public fun assert_fullsail<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: u128, arg2: u128, arg3: &0x2::clock::Clock, arg4: u64) {
        assert_clock_deadline(arg3, arg4);
        assert_bounds_u128(0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<T0, T1>(arg0), arg1, arg2);
    }

    public fun assert_magma<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: u128, arg2: u128, arg3: &0x2::clock::Clock, arg4: u64) {
        assert_clock_deadline(arg3, arg4);
        assert_bounds_u128(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0), arg1, arg2);
    }

    public fun assert_min_reserves_u64(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64) {
        assert_clock_deadline(arg4, arg5);
        assert!(arg0 >= arg2 && arg1 >= arg3, 2001);
    }

    public fun assert_mmt<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        assert_sqrt(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0), arg1, arg2);
    }

    public fun assert_ratio_x1e9(arg0: u64, arg1: u64, arg2: u128, arg3: u128) {
        assert!(arg0 > 0 && arg1 > 0, 2001);
        let v0 = (arg1 as u128) * 1000000000 / (arg0 as u128);
        assert!(v0 >= arg2 && v0 <= arg3, 2001);
    }

    public fun assert_sqrt(arg0: u128, arg1: u128, arg2: bool) {
        if (arg2) {
            assert!(arg0 >= arg1, 2001);
        } else {
            assert!(arg0 <= arg1, 2001);
        };
    }

    public fun assert_steamm_oracle_fresh(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg2: u64, arg3: &0x2::clock::Clock, arg4: u64) {
        assert_clock_deadline(arg3, arg4);
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price_no_older_than(arg0, arg3, arg2);
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price_no_older_than(arg1, arg3, arg2);
    }

    public fun assert_stsui<T0>(arg0: &0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: u64) {
        assert_clock_deadline(arg3, arg4);
        let v0 = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::lst_to_sui_redemption_price<T0>(arg0, 1000000000);
        assert!(v0 >= arg1 && v0 <= arg2, 2001);
    }

    public fun assert_suidex<T0, T1>(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        assert_sqrt(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::sqrt_price<T0, T1>(arg0), arg1, arg2);
    }

    public fun assert_turbos<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: u128, arg2: bool) {
        assert_sqrt(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

