module 0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::fuzz_harness {
    public fun optimize_cetus_triangle_scalars<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: u128, arg4: u64) : 0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::OptimizeResult {
        let v0 = 0x1::vector::empty<0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::TickBoundary>();
        0x1::vector::push_back<0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::TickBoundary>(&mut v0, 0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::tick_boundary(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), 0, false));
        let v1 = 0x1::vector::empty<0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::TickBoundary>();
        0x1::vector::push_back<0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::TickBoundary>(&mut v1, 0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::tick_boundary(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), 0, false));
        let v2 = 0x1::vector::empty<0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::TickBoundary>();
        0x1::vector::push_back<0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::TickBoundary>(&mut v2, 0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::tick_boundary(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), 0, false));
        let v3 = 0x1::vector::empty<0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::Hop>();
        let v4 = &mut v3;
        0x1::vector::push_back<0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::Hop>(v4, 0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::v3_hop(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0), 1000000, true, v0));
        0x1::vector::push_back<0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::Hop>(v4, 0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::v3_hop(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T2>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T1, T2>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T1, T2>(arg1), 1000000, true, v1));
        0x1::vector::push_back<0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::Hop>(v4, 0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::v3_hop(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T2>(arg2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T2>(arg2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T2>(arg2), 1000000, false, v2));
        0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::optimize(v3, arg3, arg4)
    }

    public fun optimize_synthetic(arg0: vector<u8>, arg1: vector<u128>, arg2: vector<u128>, arg3: vector<u128>, arg4: vector<u128>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<bool>, arg10: vector<u128>, arg11: u128, arg12: u64) : 0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::OptimizeResult {
        let v0 = 0x1::vector::length<u8>(&arg0);
        assert!(v0 >= 2, 200);
        assert!(0x1::vector::length<u128>(&arg1) == v0, 200);
        assert!(0x1::vector::length<u128>(&arg2) == v0, 200);
        assert!(0x1::vector::length<u128>(&arg3) == v0, 200);
        assert!(0x1::vector::length<u128>(&arg4) == v0, 200);
        assert!(0x1::vector::length<u64>(&arg5) == v0, 200);
        assert!(0x1::vector::length<u64>(&arg6) == v0, 200);
        assert!(0x1::vector::length<u64>(&arg7) == v0, 200);
        assert!(0x1::vector::length<u64>(&arg8) == v0, 200);
        assert!(0x1::vector::length<bool>(&arg9) == v0, 200);
        assert!(0x1::vector::length<u128>(&arg10) == v0, 200);
        let v1 = 0x1::vector::empty<0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::Hop>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u8>(&arg0, v2);
            if (v3 == 0) {
                0x1::vector::push_back<0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::Hop>(&mut v1, 0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::v2_hop_split_fee(*0x1::vector::borrow<u128>(&arg1, v2), *0x1::vector::borrow<u128>(&arg2, v2), *0x1::vector::borrow<u64>(&arg5, v2), *0x1::vector::borrow<u64>(&arg6, v2), *0x1::vector::borrow<u64>(&arg7, v2), *0x1::vector::borrow<u64>(&arg8, v2)));
            } else {
                assert!(v3 == 1, 201);
                let v4 = 0x1::vector::empty<0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::TickBoundary>();
                0x1::vector::push_back<0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::TickBoundary>(&mut v4, 0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::tick_boundary(*0x1::vector::borrow<u128>(&arg10, v2), 0, false));
                0x1::vector::push_back<0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::Hop>(&mut v1, 0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::v3_hop(*0x1::vector::borrow<u128>(&arg3, v2), *0x1::vector::borrow<u128>(&arg4, v2), *0x1::vector::borrow<u64>(&arg5, v2), *0x1::vector::borrow<u64>(&arg6, v2), *0x1::vector::borrow<bool>(&arg9, v2), v4));
            };
            v2 = v2 + 1;
        };
        0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::optimize(v1, arg11, arg12)
    }

    public fun optimize_synthetic_multitick(arg0: u8, arg1: vector<u8>, arg2: vector<u128>, arg3: vector<u128>, arg4: vector<u128>, arg5: vector<u128>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<bool>, arg11: vector<vector<u128>>, arg12: vector<vector<u128>>, arg13: vector<vector<bool>>, arg14: u128, arg15: u64) : 0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::OptimizeResult {
        let v0 = 0x1::vector::length<u8>(&arg1);
        assert!(v0 >= 2, 200);
        assert!(0x1::vector::length<u128>(&arg2) == v0, 200);
        assert!(0x1::vector::length<u128>(&arg3) == v0, 200);
        assert!(0x1::vector::length<u128>(&arg4) == v0, 200);
        assert!(0x1::vector::length<u128>(&arg5) == v0, 200);
        assert!(0x1::vector::length<u64>(&arg6) == v0, 200);
        assert!(0x1::vector::length<u64>(&arg7) == v0, 200);
        assert!(0x1::vector::length<u64>(&arg8) == v0, 200);
        assert!(0x1::vector::length<u64>(&arg9) == v0, 200);
        assert!(0x1::vector::length<bool>(&arg10) == v0, 200);
        assert!(0x1::vector::length<vector<u128>>(&arg11) == v0, 200);
        assert!(0x1::vector::length<vector<u128>>(&arg12) == v0, 200);
        assert!(0x1::vector::length<vector<bool>>(&arg13) == v0, 200);
        let v1 = 0x1::vector::empty<0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::Hop>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u8>(&arg1, v2);
            if (v3 == 0) {
                0x1::vector::push_back<0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::Hop>(&mut v1, 0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::v2_hop_split_fee(*0x1::vector::borrow<u128>(&arg2, v2), *0x1::vector::borrow<u128>(&arg3, v2), *0x1::vector::borrow<u64>(&arg6, v2), *0x1::vector::borrow<u64>(&arg7, v2), *0x1::vector::borrow<u64>(&arg8, v2), *0x1::vector::borrow<u64>(&arg9, v2)));
            } else {
                assert!(v3 == 1, 201);
                let v4 = 0x1::vector::borrow<vector<u128>>(&arg11, v2);
                let v5 = 0x1::vector::borrow<vector<u128>>(&arg12, v2);
                let v6 = 0x1::vector::borrow<vector<bool>>(&arg13, v2);
                assert!(0x1::vector::length<u128>(v4) == 0x1::vector::length<u128>(v5), 200);
                assert!(0x1::vector::length<u128>(v4) == 0x1::vector::length<bool>(v6), 200);
                let v7 = 0x1::vector::empty<0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::TickBoundary>();
                let v8 = 0;
                while (v8 < 0x1::vector::length<u128>(v4)) {
                    0x1::vector::push_back<0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::TickBoundary>(&mut v7, 0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::tick_boundary(*0x1::vector::borrow<u128>(v4, v8), *0x1::vector::borrow<u128>(v5, v8), *0x1::vector::borrow<bool>(v6, v8)));
                    v8 = v8 + 1;
                };
                0x1::vector::push_back<0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::Hop>(&mut v1, 0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::v3_hop(*0x1::vector::borrow<u128>(&arg4, v2), *0x1::vector::borrow<u128>(&arg5, v2), *0x1::vector::borrow<u64>(&arg6, v2), *0x1::vector::borrow<u64>(&arg7, v2), *0x1::vector::borrow<bool>(&arg10, v2), v7));
            };
            v2 = v2 + 1;
        };
        if (arg0 == 0) {
            0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::optimize_baseline(v1, arg14, arg15)
        } else if (arg0 == 1) {
            0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::optimize_lazy_sqrt(v1, arg14, arg15)
        } else if (arg0 == 2) {
            0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::optimize_forward_events(v1, arg14, arg15)
        } else {
            assert!(arg0 == 3, 202);
            0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::optimize_coefficients(v1, arg14, arg15)
        }
    }

    // decompiled from Move bytecode v7
}

