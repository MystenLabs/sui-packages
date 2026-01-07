module 0x12c426921f9d8670af3884b264a4765ae8483185ccdc76f2d3b6f60742f3f832::H3FL {
    fun blu_a2b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg1, true, true, 0x2::coin::value<T0>(&arg2), 4295048017);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), 0x2::balance::zero<T1>(), v2);
        0x2::balance::destroy_zero<T0>(v0);
        0x2::coin::from_balance<T1>(v1, arg4)
    }

    fun blu_b2a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg1, false, true, 0x2::coin::value<T1>(&arg2), 79226673515401279992447579054);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg2), v2);
        0x2::balance::destroy_zero<T1>(v1);
        0x2::coin::from_balance<T0>(v0, arg4)
    }

    fun cetus_swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&arg2), 4295048016, arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), 0x2::balance::zero<T1>(), v2);
        0x2::balance::destroy_zero<T0>(v0);
        0x2::coin::from_balance<T1>(v1, arg4)
    }

    fun cetus_swap_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::coin::value<T1>(&arg2), 79226673515401279992447579055, arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg2), v2);
        0x2::balance::destroy_zero<T1>(v1);
        0x2::coin::from_balance<T0>(v0, arg4)
    }

    public fun fl_cbm_fff<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg5: u64, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T1, T0>(arg0, arg1, false, arg5);
        0x2::balance::destroy_zero<T1>(v0);
        let v3 = 0x2::coin::from_balance<T0>(v1, arg8);
        let v4 = cetus_swap_b2a<T1, T0>(arg0, arg1, v3, arg7, arg8);
        let v5 = blu_b2a<T2, T1>(arg2, arg3, v4, arg7, arg8);
        let v6 = mmt_b2a<T0, T2>(arg4, v5, arg7, arg6, arg8);
        let v7 = 0x2::coin::into_balance<T0>(v6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T1, T0>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v7, arg5), v2);
        let v8 = 0x2::coin::from_balance<T0>(v7, arg8);
        assert!(0x2::coin::value<T0>(&v8) > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, 0x2::tx_context::sender(arg8));
    }

    public fun fl_cbm_ffs<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg5: u64, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T1, T0>(arg0, arg1, false, arg5);
        0x2::balance::destroy_zero<T1>(v0);
        let v3 = 0x2::coin::from_balance<T0>(v1, arg8);
        let v4 = cetus_swap_b2a<T1, T0>(arg0, arg1, v3, arg7, arg8);
        let v5 = blu_b2a<T2, T1>(arg2, arg3, v4, arg7, arg8);
        let v6 = mmt_a2b<T2, T0>(arg4, v5, arg7, arg6, arg8);
        let v7 = 0x2::coin::into_balance<T0>(v6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T1, T0>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v7, arg5), v2);
        let v8 = 0x2::coin::from_balance<T0>(v7, arg8);
        assert!(0x2::coin::value<T0>(&v8) > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, 0x2::tx_context::sender(arg8));
    }

    public fun fl_cbm_fsf<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg5: u64, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T1, T0>(arg0, arg1, false, arg5);
        0x2::balance::destroy_zero<T1>(v0);
        let v3 = 0x2::coin::from_balance<T0>(v1, arg8);
        let v4 = cetus_swap_b2a<T1, T0>(arg0, arg1, v3, arg7, arg8);
        let v5 = blu_a2b<T1, T2>(arg2, arg3, v4, arg7, arg8);
        let v6 = mmt_b2a<T0, T2>(arg4, v5, arg7, arg6, arg8);
        let v7 = 0x2::coin::into_balance<T0>(v6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T1, T0>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v7, arg5), v2);
        let v8 = 0x2::coin::from_balance<T0>(v7, arg8);
        assert!(0x2::coin::value<T0>(&v8) > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, 0x2::tx_context::sender(arg8));
    }

    public fun fl_cbm_fss<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg5: u64, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T1, T0>(arg0, arg1, false, arg5);
        0x2::balance::destroy_zero<T1>(v0);
        let v3 = 0x2::coin::from_balance<T0>(v1, arg8);
        let v4 = cetus_swap_b2a<T1, T0>(arg0, arg1, v3, arg7, arg8);
        let v5 = blu_a2b<T1, T2>(arg2, arg3, v4, arg7, arg8);
        let v6 = mmt_a2b<T2, T0>(arg4, v5, arg7, arg6, arg8);
        let v7 = 0x2::coin::into_balance<T0>(v6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T1, T0>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v7, arg5), v2);
        let v8 = 0x2::coin::from_balance<T0>(v7, arg8);
        assert!(0x2::coin::value<T0>(&v8) > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, 0x2::tx_context::sender(arg8));
    }

    public fun fl_cbm_sff<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg5: u64, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg5);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x2::coin::from_balance<T0>(v0, arg8);
        let v4 = cetus_swap_a2b<T0, T1>(arg0, arg1, v3, arg7, arg8);
        let v5 = blu_b2a<T2, T1>(arg2, arg3, v4, arg7, arg8);
        let v6 = mmt_b2a<T0, T2>(arg4, v5, arg7, arg6, arg8);
        let v7 = 0x2::coin::into_balance<T0>(v6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v7, arg5), 0x2::balance::zero<T1>(), v2);
        let v8 = 0x2::coin::from_balance<T0>(v7, arg8);
        assert!(0x2::coin::value<T0>(&v8) > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, 0x2::tx_context::sender(arg8));
    }

    public fun fl_cbm_sfs<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg5: u64, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg5);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x2::coin::from_balance<T0>(v0, arg8);
        let v4 = cetus_swap_a2b<T0, T1>(arg0, arg1, v3, arg7, arg8);
        let v5 = blu_b2a<T2, T1>(arg2, arg3, v4, arg7, arg8);
        let v6 = mmt_a2b<T2, T0>(arg4, v5, arg7, arg6, arg8);
        let v7 = 0x2::coin::into_balance<T0>(v6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v7, arg5), 0x2::balance::zero<T1>(), v2);
        let v8 = 0x2::coin::from_balance<T0>(v7, arg8);
        assert!(0x2::coin::value<T0>(&v8) > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, 0x2::tx_context::sender(arg8));
    }

    public fun fl_cbm_ssf<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg5: u64, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg5);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x2::coin::from_balance<T0>(v0, arg8);
        let v4 = cetus_swap_a2b<T0, T1>(arg0, arg1, v3, arg7, arg8);
        let v5 = blu_a2b<T1, T2>(arg2, arg3, v4, arg7, arg8);
        let v6 = mmt_b2a<T0, T2>(arg4, v5, arg7, arg6, arg8);
        let v7 = 0x2::coin::into_balance<T0>(v6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v7, arg5), 0x2::balance::zero<T1>(), v2);
        let v8 = 0x2::coin::from_balance<T0>(v7, arg8);
        assert!(0x2::coin::value<T0>(&v8) > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, 0x2::tx_context::sender(arg8));
    }

    public fun fl_cbm_sss<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg5: u64, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg5);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x2::coin::from_balance<T0>(v0, arg8);
        let v4 = cetus_swap_a2b<T0, T1>(arg0, arg1, v3, arg7, arg8);
        let v5 = blu_a2b<T1, T2>(arg2, arg3, v4, arg7, arg8);
        let v6 = mmt_a2b<T2, T0>(arg4, v5, arg7, arg6, arg8);
        let v7 = 0x2::coin::into_balance<T0>(v6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v7, arg5), 0x2::balance::zero<T1>(), v2);
        let v8 = 0x2::coin::from_balance<T0>(v7, arg8);
        assert!(0x2::coin::value<T0>(&v8) > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, 0x2::tx_context::sender(arg8));
    }

    public fun fl_cmb_fff<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg5: u64, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T1, T0>(arg0, arg1, false, arg5);
        0x2::balance::destroy_zero<T1>(v0);
        let v3 = 0x2::coin::from_balance<T0>(v1, arg8);
        let v4 = cetus_swap_b2a<T1, T0>(arg0, arg1, v3, arg7, arg8);
        let v5 = mmt_b2a<T2, T1>(arg2, v4, arg7, arg6, arg8);
        let v6 = blu_b2a<T0, T2>(arg3, arg4, v5, arg7, arg8);
        let v7 = 0x2::coin::into_balance<T0>(v6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T1, T0>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v7, arg5), v2);
        let v8 = 0x2::coin::from_balance<T0>(v7, arg8);
        assert!(0x2::coin::value<T0>(&v8) > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, 0x2::tx_context::sender(arg8));
    }

    public fun fl_cmb_ffs<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg5: u64, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T1, T0>(arg0, arg1, false, arg5);
        0x2::balance::destroy_zero<T1>(v0);
        let v3 = 0x2::coin::from_balance<T0>(v1, arg8);
        let v4 = cetus_swap_b2a<T1, T0>(arg0, arg1, v3, arg7, arg8);
        let v5 = mmt_b2a<T2, T1>(arg2, v4, arg7, arg6, arg8);
        let v6 = blu_a2b<T2, T0>(arg3, arg4, v5, arg7, arg8);
        let v7 = 0x2::coin::into_balance<T0>(v6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T1, T0>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v7, arg5), v2);
        let v8 = 0x2::coin::from_balance<T0>(v7, arg8);
        assert!(0x2::coin::value<T0>(&v8) > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, 0x2::tx_context::sender(arg8));
    }

    public fun fl_cmb_fsf<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg5: u64, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T1, T0>(arg0, arg1, false, arg5);
        0x2::balance::destroy_zero<T1>(v0);
        let v3 = 0x2::coin::from_balance<T0>(v1, arg8);
        let v4 = cetus_swap_b2a<T1, T0>(arg0, arg1, v3, arg7, arg8);
        let v5 = mmt_a2b<T1, T2>(arg2, v4, arg7, arg6, arg8);
        let v6 = blu_b2a<T0, T2>(arg3, arg4, v5, arg7, arg8);
        let v7 = 0x2::coin::into_balance<T0>(v6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T1, T0>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v7, arg5), v2);
        let v8 = 0x2::coin::from_balance<T0>(v7, arg8);
        assert!(0x2::coin::value<T0>(&v8) > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, 0x2::tx_context::sender(arg8));
    }

    public fun fl_cmb_fss<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg5: u64, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T1, T0>(arg0, arg1, false, arg5);
        0x2::balance::destroy_zero<T1>(v0);
        let v3 = 0x2::coin::from_balance<T0>(v1, arg8);
        let v4 = cetus_swap_b2a<T1, T0>(arg0, arg1, v3, arg7, arg8);
        let v5 = mmt_a2b<T1, T2>(arg2, v4, arg7, arg6, arg8);
        let v6 = blu_a2b<T2, T0>(arg3, arg4, v5, arg7, arg8);
        let v7 = 0x2::coin::into_balance<T0>(v6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T1, T0>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v7, arg5), v2);
        let v8 = 0x2::coin::from_balance<T0>(v7, arg8);
        assert!(0x2::coin::value<T0>(&v8) > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, 0x2::tx_context::sender(arg8));
    }

    public fun fl_cmb_sff<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg5: u64, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg5);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x2::coin::from_balance<T0>(v0, arg8);
        let v4 = cetus_swap_a2b<T0, T1>(arg0, arg1, v3, arg7, arg8);
        let v5 = mmt_b2a<T2, T1>(arg2, v4, arg7, arg6, arg8);
        let v6 = blu_b2a<T0, T2>(arg3, arg4, v5, arg7, arg8);
        let v7 = 0x2::coin::into_balance<T0>(v6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v7, arg5), 0x2::balance::zero<T1>(), v2);
        let v8 = 0x2::coin::from_balance<T0>(v7, arg8);
        assert!(0x2::coin::value<T0>(&v8) > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, 0x2::tx_context::sender(arg8));
    }

    public fun fl_cmb_sfs<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg5: u64, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg5);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x2::coin::from_balance<T0>(v0, arg8);
        let v4 = cetus_swap_a2b<T0, T1>(arg0, arg1, v3, arg7, arg8);
        let v5 = mmt_b2a<T2, T1>(arg2, v4, arg7, arg6, arg8);
        let v6 = blu_a2b<T2, T0>(arg3, arg4, v5, arg7, arg8);
        let v7 = 0x2::coin::into_balance<T0>(v6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v7, arg5), 0x2::balance::zero<T1>(), v2);
        let v8 = 0x2::coin::from_balance<T0>(v7, arg8);
        assert!(0x2::coin::value<T0>(&v8) > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, 0x2::tx_context::sender(arg8));
    }

    public fun fl_cmb_ssf<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg5: u64, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg5);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x2::coin::from_balance<T0>(v0, arg8);
        let v4 = cetus_swap_a2b<T0, T1>(arg0, arg1, v3, arg7, arg8);
        let v5 = mmt_a2b<T1, T2>(arg2, v4, arg7, arg6, arg8);
        let v6 = blu_b2a<T0, T2>(arg3, arg4, v5, arg7, arg8);
        let v7 = 0x2::coin::into_balance<T0>(v6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v7, arg5), 0x2::balance::zero<T1>(), v2);
        let v8 = 0x2::coin::from_balance<T0>(v7, arg8);
        assert!(0x2::coin::value<T0>(&v8) > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, 0x2::tx_context::sender(arg8));
    }

    public fun fl_cmb_sss<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg5: u64, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg5);
        0x2::balance::destroy_zero<T1>(v1);
        let v3 = 0x2::coin::from_balance<T0>(v0, arg8);
        let v4 = cetus_swap_a2b<T0, T1>(arg0, arg1, v3, arg7, arg8);
        let v5 = mmt_a2b<T1, T2>(arg2, v4, arg7, arg6, arg8);
        let v6 = blu_a2b<T2, T0>(arg3, arg4, v5, arg7, arg8);
        let v7 = 0x2::coin::into_balance<T0>(v6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v7, arg5), 0x2::balance::zero<T1>(), v2);
        let v8 = 0x2::coin::from_balance<T0>(v7, arg8);
        assert!(0x2::coin::value<T0>(&v8) > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, 0x2::tx_context::sender(arg8));
    }

    fun mmt_a2b<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, true, true, 0x2::coin::value<T0>(&arg1), 4295048016, arg2, arg3, arg4);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v2, 0x2::coin::into_balance<T0>(arg1), 0x2::balance::zero<T1>(), arg3, arg4);
        0x2::balance::destroy_zero<T0>(v0);
        0x2::coin::from_balance<T1>(v1, arg4)
    }

    fun mmt_b2a<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, false, true, 0x2::coin::value<T1>(&arg1), 79226673515401279992447579055, arg2, arg3, arg4);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg1), arg3, arg4);
        0x2::balance::destroy_zero<T1>(v1);
        0x2::coin::from_balance<T0>(v0, arg4)
    }

    // decompiled from Move bytecode v6
}

