module 0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::arbitrage {
    struct BestPoolEvent has copy, drop {
        step0_pool: u16,
        step1_pool: u16,
    }

    struct CalculatedAmountEvent has copy, drop {
        amount_in: u64,
        earning: u64,
    }

    public fun arbitrage<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg5: &mut 0x2::coin::Coin<T0>, arg6: &mut 0x2::coin::Coin<T1>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg10: &0x2::clock::Clock, arg11: u64, arg12: u64, arg13: bool, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = arg11;
        let v2 = !arg13;
        let v3 = 0;
        let v4 = v3;
        let v5 = 0;
        let v6 = v5;
        let v7 = 57005;
        let v8 = 57005;
        let v9 = 0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::bluefin::calculate<T0, T1>(arg0, arg13, arg11);
        if (v9 > v3) {
            v7 = 0;
            v4 = v9;
        };
        let v10 = 0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::bluefin::calculate<T0, T1>(arg1, arg13, arg11);
        if (v10 > v4) {
            v7 = 1;
            v4 = v10;
        };
        let v11 = 0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::cetus::calculate<T0, T1>(arg2, arg13, arg11);
        if (v11 > v4) {
            v7 = 2;
            v4 = v11;
        };
        let v12 = 0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::cetus::calculate<T0, T1>(arg3, arg13, arg11);
        if (v12 > v4) {
            v7 = 3;
            v4 = v12;
        };
        let v13 = 0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::mmt::calculate<T0, T1>(arg4, arg13, arg11);
        if (v13 > v4) {
            v7 = 4;
            v4 = v13;
        };
        if (v7 != 0) {
            let v14 = 0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::bluefin::calculate<T0, T1>(arg0, v2, v4);
            if (v14 > v5) {
                v8 = 0;
                v6 = v14;
            };
        };
        if (v7 != 1) {
            let v15 = 0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::bluefin::calculate<T0, T1>(arg1, v2, v4);
            if (v15 > v6) {
                v8 = 1;
                v6 = v15;
            };
        };
        if (v7 != 2) {
            let v16 = 0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::cetus::calculate<T0, T1>(arg2, v2, v4);
            if (v16 > v6) {
                v8 = 2;
                v6 = v16;
            };
        };
        if (v7 != 3) {
            let v17 = 0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::cetus::calculate<T0, T1>(arg3, v2, v4);
            if (v17 > v6) {
                v8 = 3;
                v6 = v17;
            };
        };
        if (v7 != 4) {
            let v18 = 0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::mmt::calculate<T0, T1>(arg4, v2, v4);
            if (v18 > v6) {
                v8 = 4;
                v6 = v18;
            };
        };
        let v19 = BestPoolEvent{
            step0_pool : v7,
            step1_pool : v8,
        };
        0x2::event::emit<BestPoolEvent>(v19);
        if (v6 > arg11) {
            v0 = v6 - arg11;
        };
        let v20 = 0;
        while (v20 < 4) {
            v20 = v20 + 1;
            let v21 = if (v0 >= arg12) {
                v1 * 2
            } else {
                v1 / 2
            };
            let v22 = v7;
            let v23 = &v22;
            let v24 = if (*v23 == 0) {
                0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::bluefin::calculate<T0, T1>(arg0, arg13, v21)
            } else if (*v23 == 1) {
                0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::bluefin::calculate<T0, T1>(arg1, arg13, v21)
            } else if (*v23 == 2) {
                0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::cetus::calculate<T0, T1>(arg2, arg13, v21)
            } else if (*v23 == 3) {
                0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::cetus::calculate<T0, T1>(arg3, arg13, v21)
            } else {
                assert!(*v23 == 4, 0);
                0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::mmt::calculate<T0, T1>(arg4, arg13, v21)
            };
            let v25 = v8;
            let v26 = &v25;
            let v27 = if (*v26 == 0) {
                0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::bluefin::calculate<T0, T1>(arg0, v2, v24)
            } else if (*v26 == 1) {
                0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::bluefin::calculate<T0, T1>(arg1, v2, v24)
            } else if (*v26 == 2) {
                0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::cetus::calculate<T0, T1>(arg2, v2, v24)
            } else if (*v26 == 3) {
                0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::cetus::calculate<T0, T1>(arg3, v2, v24)
            } else {
                assert!(*v26 == 4, 1);
                0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::mmt::calculate<T0, T1>(arg4, v2, v24)
            };
            if (v0 >= arg12) {
                if (v27 > v21) {
                    if (v27 - v21 > v0) {
                        v1 = v21;
                        v0 = v27 - v21;
                        continue
                    } else {
                        break
                    };
                } else {
                    break
                };
            };
            if (v27 > v21) {
                if (v27 - v21 >= arg12) {
                    v1 = v21;
                    v0 = v27 - v21;
                    break
                };
            };
        };
        if (arg12 > 2) {
            assert!(v0 >= arg12, 2);
        };
        let v28 = CalculatedAmountEvent{
            amount_in : v1,
            earning   : v0,
        };
        0x2::event::emit<CalculatedAmountEvent>(v28);
        if (arg12 == 0) {
            return
        };
        let (v29, v30) = if (arg13) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg5, v1, arg14)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg6, v1, arg14)))
        };
        let v31 = v7;
        let v32 = &v31;
        let (v33, v34) = if (*v32 == 0) {
            0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::bluefin::swap<T0, T1>(arg0, v29, v30, arg13, arg7, arg10)
        } else if (*v32 == 1) {
            0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::bluefin::swap<T0, T1>(arg1, v29, v30, arg13, arg7, arg10)
        } else if (*v32 == 2) {
            0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::cetus::swap<T0, T1>(arg2, v29, v30, arg13, arg8, arg10)
        } else if (*v32 == 3) {
            0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::cetus::swap<T0, T1>(arg3, v29, v30, arg13, arg8, arg10)
        } else {
            assert!(*v32 == 4, 3);
            0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::mmt::swap<T0, T1>(arg4, v29, v30, arg13, arg9, arg10, arg14)
        };
        let v35 = v8;
        let v36 = &v35;
        let (v37, v38) = if (*v36 == 0) {
            0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::bluefin::swap<T0, T1>(arg0, v33, v34, v2, arg7, arg10)
        } else if (*v36 == 1) {
            0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::bluefin::swap<T0, T1>(arg1, v33, v34, v2, arg7, arg10)
        } else if (*v36 == 2) {
            0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::cetus::swap<T0, T1>(arg2, v33, v34, v2, arg8, arg10)
        } else if (*v36 == 3) {
            0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::cetus::swap<T0, T1>(arg3, v33, v34, v2, arg8, arg10)
        } else {
            assert!(*v36 == 4, 4);
            0x3d3991e7cd759af4e29b595de083c1e74121a3bb32e1454f4e113c3dbd8a7720::mmt::swap<T0, T1>(arg4, v33, v34, v2, arg9, arg10, arg14)
        };
        0x2::coin::join<T0>(arg5, 0x2::coin::from_balance<T0>(v37, arg14));
        0x2::coin::join<T1>(arg6, 0x2::coin::from_balance<T1>(v38, arg14));
    }

    // decompiled from Move bytecode v6
}

