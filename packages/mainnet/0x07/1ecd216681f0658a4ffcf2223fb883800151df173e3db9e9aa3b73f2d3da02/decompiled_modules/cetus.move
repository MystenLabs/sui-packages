module 0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::cetus {
    public fun atob<T0, T1>(arg0: &0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::control::Permits, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: vector<0x2::coin::Coin<T0>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::control::valid(arg0, 0x2::tx_context::sender(arg6));
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, arg4, 4295048016, arg5);
        let v3 = v1;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = 0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::help::merge_all<T0>(arg3, arg6);
        0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::help::transfer<T0>(v4, 0x2::tx_context::sender(arg6));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, arg4, arg6)), 0x2::balance::zero<T1>(), v2);
        (0x2::coin::from_balance<T1>(v3, arg6), 0x2::balance::value<T1>(&v3))
    }

    public fun atob1<T0, T1>(arg0: &0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::control::Permits, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: vector<0x2::coin::Coin<T0>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T1>>, u64) {
        let (v0, v1) = atob<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v2, v0);
        (v2, v1)
    }

    public fun btoa<T0, T1>(arg0: &0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::control::Permits, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: vector<0x2::coin::Coin<T1>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::control::valid(arg0, 0x2::tx_context::sender(arg6));
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, arg4, 79226673515401279992447579055, arg5);
        let v3 = v0;
        0x2::balance::destroy_zero<T1>(v1);
        let v4 = 0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::help::merge_all<T1>(arg3, arg6);
        0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::help::transfer<T1>(v4, 0x2::tx_context::sender(arg6));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v4, arg4, arg6)), v2);
        (0x2::coin::from_balance<T0>(v3, arg6), 0x2::balance::value<T0>(&v3))
    }

    public fun btoa1<T0, T1>(arg0: &0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::control::Permits, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: vector<0x2::coin::Coin<T1>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T0>>, u64) {
        let (v0, v1) = btoa<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, v0);
        (v2, v1)
    }

    public fun xy_xy<T0, T1, T2>(arg0: &0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::control::Permits, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: vector<0x2::coin::Coin<T0>>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, u64) {
        let (v0, v1) = atob<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v2, v0);
        atob<T1, T2>(arg0, arg1, arg3, v2, v1, arg6, arg7)
    }

    public fun xy_xy1<T0, T1, T2>(arg0: &0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::control::Permits, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: vector<0x2::coin::Coin<T0>>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T2>>, u64) {
        let (v0, v1) = xy_xy<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T2>>();
        0x1::vector::push_back<0x2::coin::Coin<T2>>(&mut v2, v0);
        (v2, v1)
    }

    public fun xy_yx<T0, T1, T2>(arg0: &0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::control::Permits, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: vector<0x2::coin::Coin<T0>>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, u64) {
        let (v0, v1) = atob<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v2, v0);
        btoa<T2, T1>(arg0, arg1, arg3, v2, v1, arg6, arg7)
    }

    public fun xy_yx1<T0, T1, T2>(arg0: &0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::control::Permits, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: vector<0x2::coin::Coin<T0>>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T2>>, u64) {
        let (v0, v1) = xy_yx<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T2>>();
        0x1::vector::push_back<0x2::coin::Coin<T2>>(&mut v2, v0);
        (v2, v1)
    }

    public fun yx_xy<T0, T1, T2>(arg0: &0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::control::Permits, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: vector<0x2::coin::Coin<T1>>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, u64) {
        let (v0, v1) = btoa<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, v0);
        atob<T0, T2>(arg0, arg1, arg3, v2, v1, arg6, arg7)
    }

    public fun yx_xy1<T0, T1, T2>(arg0: &0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::control::Permits, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: vector<0x2::coin::Coin<T1>>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T2>>, u64) {
        let (v0, v1) = yx_xy<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T2>>();
        0x1::vector::push_back<0x2::coin::Coin<T2>>(&mut v2, v0);
        (v2, v1)
    }

    public fun yx_yx<T0, T1, T2>(arg0: &0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::control::Permits, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: vector<0x2::coin::Coin<T1>>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, u64) {
        let (v0, v1) = btoa<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, v0);
        btoa<T2, T0>(arg0, arg1, arg3, v2, v1, arg6, arg7)
    }

    public fun yx_yx1<T0, T1, T2>(arg0: &0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::control::Permits, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: vector<0x2::coin::Coin<T1>>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T2>>, u64) {
        let (v0, v1) = yx_yx<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T2>>();
        0x1::vector::push_back<0x2::coin::Coin<T2>>(&mut v2, v0);
        (v2, v1)
    }

    // decompiled from Move bytecode v6
}

