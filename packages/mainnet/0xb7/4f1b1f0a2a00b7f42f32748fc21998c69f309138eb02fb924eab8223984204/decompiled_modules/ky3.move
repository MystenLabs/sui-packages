module 0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::ky3 {
    public fun atob<T0, T1>(arg0: &0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::control::Permits, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::control::valid(arg0, 0x2::tx_context::sender(arg6));
        let (v0, v1, v2) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg1, true, true, arg3, 4295048016, arg4, arg5, arg6);
        let v3 = v1;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = 0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::help::merge_all<T0>(arg2, arg6);
        0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::help::transfer<T0>(v4, 0x2::tx_context::sender(arg6));
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg1, v2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, arg3, arg6)), 0x2::balance::zero<T1>(), arg5, arg6);
        (0x2::coin::from_balance<T1>(v3, arg6), 0x2::balance::value<T1>(&v3))
    }

    public fun atob1<T0, T1>(arg0: &0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::control::Permits, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg6: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T1>>, u64) {
        let (v0, v1) = atob<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v2, v0);
        (v2, v1)
    }

    public fun btoa<T0, T1>(arg0: &0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::control::Permits, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::control::valid(arg0, 0x2::tx_context::sender(arg6));
        let (v0, v1, v2) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg1, false, true, arg3, 79226673515401279992447579055, arg4, arg5, arg6);
        let v3 = v0;
        0x2::balance::destroy_zero<T1>(v1);
        let v4 = 0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::help::merge_all<T1>(arg2, arg6);
        0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::help::transfer<T1>(v4, 0x2::tx_context::sender(arg6));
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg1, v2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v4, arg3, arg6)), arg5, arg6);
        (0x2::coin::from_balance<T0>(v3, arg6), 0x2::balance::value<T0>(&v3))
    }

    public fun btoa1<T0, T1>(arg0: &0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::control::Permits, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg6: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T0>>, u64) {
        let (v0, v1) = btoa<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, v0);
        (v2, v1)
    }

    public fun xy_xy<T0, T1, T2>(arg0: &0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::control::Permits, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T1, T2>, arg3: vector<0x2::coin::Coin<T0>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, u64) {
        let (v0, v1) = atob<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, arg7);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v2, v0);
        atob<T1, T2>(arg0, arg2, v2, v1, arg5, arg6, arg7)
    }

    public fun xy_xy1<T0, T1, T2>(arg0: &0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::control::Permits, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T1, T2>, arg3: vector<0x2::coin::Coin<T0>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg7: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T2>>, u64) {
        let (v0, v1) = xy_xy<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T2>>();
        0x1::vector::push_back<0x2::coin::Coin<T2>>(&mut v2, v0);
        (v2, v1)
    }

    public fun xy_yx<T0, T1, T2>(arg0: &0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::control::Permits, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T2, T1>, arg3: vector<0x2::coin::Coin<T0>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, u64) {
        let (v0, v1) = atob<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, arg7);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v2, v0);
        btoa<T2, T1>(arg0, arg2, v2, v1, arg5, arg6, arg7)
    }

    public fun xy_yx1<T0, T1, T2>(arg0: &0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::control::Permits, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T2, T1>, arg3: vector<0x2::coin::Coin<T0>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg7: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T2>>, u64) {
        let (v0, v1) = xy_yx<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T2>>();
        0x1::vector::push_back<0x2::coin::Coin<T2>>(&mut v2, v0);
        (v2, v1)
    }

    public fun yx_xy<T0, T1, T2>(arg0: &0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::control::Permits, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T2>, arg3: vector<0x2::coin::Coin<T1>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, u64) {
        let (v0, v1) = btoa<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, arg7);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, v0);
        atob<T0, T2>(arg0, arg2, v2, v1, arg5, arg6, arg7)
    }

    public fun yx_xy1<T0, T1, T2>(arg0: &0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::control::Permits, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T2>, arg3: vector<0x2::coin::Coin<T1>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg7: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T2>>, u64) {
        let (v0, v1) = yx_xy<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T2>>();
        0x1::vector::push_back<0x2::coin::Coin<T2>>(&mut v2, v0);
        (v2, v1)
    }

    public fun yx_yx<T0, T1, T2>(arg0: &0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::control::Permits, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T2, T0>, arg3: vector<0x2::coin::Coin<T1>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, u64) {
        let (v0, v1) = btoa<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, arg7);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, v0);
        btoa<T2, T0>(arg0, arg2, v2, v1, arg5, arg6, arg7)
    }

    public fun yx_yx1<T0, T1, T2>(arg0: &0x35b9763e287ddc098e58a4c04915ac039a23dfa9be62ff5778b658cb5c7837d3::control::Permits, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T2, T0>, arg3: vector<0x2::coin::Coin<T1>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg7: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T2>>, u64) {
        let (v0, v1) = yx_yx<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T2>>();
        0x1::vector::push_back<0x2::coin::Coin<T2>>(&mut v2, v0);
        (v2, v1)
    }

    // decompiled from Move bytecode v6
}

