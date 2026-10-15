module 0x85c268aabeaa0231403f4dbff504c8c47d6a08f0ea585e25ddd94a32b3fb49a9::graduator {
    struct CetusGraduator has drop {
        dummy_field: bool,
    }

    public fun collect_fees<T0>(arg0: &0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::Config, arg1: &mut 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::curve::Curve<T0>, arg2: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::curve::pool<T0>(arg1) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg4)), 13906834676854882310);
        let v0 = CetusGraduator{dummy_field: false};
        let (v1, v2) = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::collect_fee<T0, 0x2::sui::SUI>(arg2, arg3, arg4, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::curve::borrow_lock_mut<T0, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof, CetusGraduator>(arg0, v0, arg1), arg5);
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::curve::add_creator_fees<T0>(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(v2), 0x2::coin::into_balance<T0>(v1));
    }

    public fun graduate<T0>(arg0: &0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::Config, arg1: &mut 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::curve::Curve<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::is_right_order<T0, 0x2::sui::SUI>(), 13906834380501876738);
        assert!(0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::curve::has_pool_cap<T0>(arg1), 13906834384796975108);
        let v0 = CetusGraduator{dummy_field: false};
        let (v1, v2, v3) = 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::curve::begin_graduation<T0, CetusGraduator>(arg0, v0, arg1, arg6);
        let v4 = v2;
        let v5 = v1;
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(200);
        let v8 = CetusGraduator{dummy_field: false};
        let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3_with_creation_cap<T0, 0x2::sui::SUI>(arg2, arg3, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::curve::borrow_pool_cap<T0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap, CetusGraduator>(arg0, v8, arg1), 200, sqrt_price_x64(0x2::coin::value<T0>(&v4), 0x2::coin::value<0x2::sui::SUI>(&v5)), 0x1::string::utf8(b""), v6, v7, v4, v5, true, arg5, arg6);
        let v12 = v9;
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::curve::finish_graduation<T0, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(arg1, v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v12), 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp_v2(arg4, v12, arg6), v11, v10);
    }

    public fun graduate_open<T0>(arg0: &0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::Config, arg1: &mut 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::curve::Curve<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::is_right_order<T0, 0x2::sui::SUI>(), 13906834539415666690);
        let v0 = CetusGraduator{dummy_field: false};
        let (v1, v2, v3) = 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::curve::begin_graduation<T0, CetusGraduator>(arg0, v0, arg1, arg6);
        let v4 = v2;
        let v5 = v1;
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(200);
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3<T0, 0x2::sui::SUI>(arg2, arg3, 200, sqrt_price_x64(0x2::coin::value<T0>(&v4), 0x2::coin::value<0x2::sui::SUI>(&v5)), 0x1::string::utf8(b""), v6, v7, v4, v5, true, arg5, arg6);
        let v11 = v8;
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::curve::finish_graduation<T0, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(arg1, v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v11), 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp_v2(arg4, v11, arg6), v10, v9);
    }

    public fun sqrt_price_x64(arg0: u64, arg1: u64) : u128 {
        0x1::u128::sqrt(((((arg1 as u256) << 128) / (arg0 as u256)) as u128))
    }

    // decompiled from Move bytecode v7
}

