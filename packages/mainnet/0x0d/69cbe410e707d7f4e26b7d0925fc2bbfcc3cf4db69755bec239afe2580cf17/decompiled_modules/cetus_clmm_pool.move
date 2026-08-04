module 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_pool {
    public(friend) fun swap_all_base_to_lst<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params::RiskParams, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg2);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T1>(arg2);
            return 0x2::coin::zero<T0>(arg6)
        };
        0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_oracle::assert_pool_spot<T0, T1>(arg3, arg1, arg4);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, v0, 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_oracle::wal_to_hawal_sqrt_limit(arg3, arg4), arg5);
        let v4 = v3;
        let v5 = v1;
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4) == v0, 224);
        0x2::balance::destroy_zero<T1>(v2);
        assert!(0x2::balance::value<T0>(&v5) >= 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_oracle::min_wal_to_hawal(arg3, v0, arg4), 238);
        0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_oracle::assert_pool_spot<T0, T1>(arg3, arg1, arg4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg2), v4);
        0x2::coin::from_balance<T0>(v5, arg6)
    }

    public(friend) fun swap_all_lst_to_base<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg4: &0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_cetus_clmm_params::RiskParams, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg2);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T1>(arg2);
            return 0x2::coin::zero<T0>(arg6)
        };
        0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_oracle::assert_pool_spot<T1, T0>(arg3, arg1, arg4);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg0, arg1, true, true, v0, 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_oracle::hawal_to_wal_sqrt_limit(arg3, arg4), arg5);
        let v4 = v3;
        let v5 = v2;
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v4) == v0, 224);
        0x2::balance::destroy_zero<T1>(v1);
        assert!(0x2::balance::value<T0>(&v5) >= 0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_oracle::min_hawal_to_wal(arg3, v0, arg4), 238);
        0x1151ce70452615dc67e9c3bd6775a928a83c96ddb3f75c76f2a67d05f41a738f::cetus_clmm_oracle::assert_pool_spot<T1, T0>(arg3, arg1, arg4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg0, arg1, 0x2::coin::into_balance<T1>(arg2), 0x2::balance::zero<T0>(), v4);
        0x2::coin::from_balance<T0>(v5, arg6)
    }

    // decompiled from Move bytecode v7
}

