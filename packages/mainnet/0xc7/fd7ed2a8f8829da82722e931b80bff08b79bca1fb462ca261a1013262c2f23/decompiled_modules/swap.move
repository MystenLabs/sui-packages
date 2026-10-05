module 0xc7fd7ed2a8f8829da82722e931b80bff08b79bca1fb462ca261a1013262c2f23::swap {
    struct Witness has drop {
        dummy_field: bool,
    }

    public fun bluefin_a2b<T0, T1>(arg0: &mut 0x654cfad8a0d8f0a074eb66096b8a81604cc9d6ff88c5289e5bbc93d904387301::vault::Vault, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let (v1, v2) = 0x654cfad8a0d8f0a074eb66096b8a81604cc9d6ff88c5289e5bbc93d904387301::vault::take<Witness, T0, T1>(arg0, v0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), arg3, arg4, arg6, arg7, arg8);
        let v3 = v1;
        let (v4, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg7, arg1, arg2, true, true, arg3, bound(arg5, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg2), true));
        let v7 = v6;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v7)), 0x2::balance::zero<T1>(), v7);
        0x2::balance::join<T0>(&mut v3, v4);
        let v8 = Witness{dummy_field: false};
        0x654cfad8a0d8f0a074eb66096b8a81604cc9d6ff88c5289e5bbc93d904387301::vault::settle<Witness, T0, T1>(arg0, v8, v2, v3, v5);
    }

    public fun bluefin_b2a<T0, T1>(arg0: &mut 0x654cfad8a0d8f0a074eb66096b8a81604cc9d6ff88c5289e5bbc93d904387301::vault::Vault, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let (v1, v2) = 0x654cfad8a0d8f0a074eb66096b8a81604cc9d6ff88c5289e5bbc93d904387301::vault::take<Witness, T1, T0>(arg0, v0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), arg3, arg4, arg6, arg7, arg8);
        let v3 = v1;
        let (v4, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg7, arg1, arg2, false, true, arg3, bound(arg5, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg2), false));
        let v7 = v6;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v7)), v7);
        0x2::balance::join<T1>(&mut v3, v5);
        let v8 = Witness{dummy_field: false};
        0x654cfad8a0d8f0a074eb66096b8a81604cc9d6ff88c5289e5bbc93d904387301::vault::settle<Witness, T1, T0>(arg0, v8, v2, v3, v4);
    }

    public(friend) fun bound(arg0: u128, arg1: u128, arg2: bool) : u128 {
        if (arg2) {
            assert!(arg0 < arg1, 1);
            0x1::u128::max(arg0, 4295048016)
        } else {
            assert!(arg0 > arg1, 1);
            0x1::u128::min(arg0, 79226673515401279992447579055)
        }
    }

    public fun cetus_a2b<T0, T1>(arg0: &mut 0x654cfad8a0d8f0a074eb66096b8a81604cc9d6ff88c5289e5bbc93d904387301::vault::Vault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let (v1, v2) = 0x654cfad8a0d8f0a074eb66096b8a81604cc9d6ff88c5289e5bbc93d904387301::vault::take<Witness, T0, T1>(arg0, v0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), arg3, arg4, arg6, arg7, arg8);
        let v3 = v1;
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, arg3, bound(arg5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2), true), arg7);
        let v7 = v6;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v7)), 0x2::balance::zero<T1>(), v7);
        0x2::balance::join<T0>(&mut v3, v4);
        let v8 = Witness{dummy_field: false};
        0x654cfad8a0d8f0a074eb66096b8a81604cc9d6ff88c5289e5bbc93d904387301::vault::settle<Witness, T0, T1>(arg0, v8, v2, v3, v5);
    }

    public fun cetus_b2a<T0, T1>(arg0: &mut 0x654cfad8a0d8f0a074eb66096b8a81604cc9d6ff88c5289e5bbc93d904387301::vault::Vault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let (v1, v2) = 0x654cfad8a0d8f0a074eb66096b8a81604cc9d6ff88c5289e5bbc93d904387301::vault::take<Witness, T1, T0>(arg0, v0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), arg3, arg4, arg6, arg7, arg8);
        let v3 = v1;
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, arg3, bound(arg5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2), false), arg7);
        let v7 = v6;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v7)), v7);
        0x2::balance::join<T1>(&mut v3, v5);
        let v8 = Witness{dummy_field: false};
        0x654cfad8a0d8f0a074eb66096b8a81604cc9d6ff88c5289e5bbc93d904387301::vault::settle<Witness, T1, T0>(arg0, v8, v2, v3, v4);
    }

    public fun magma_a2b<T0, T1>(arg0: &mut 0x654cfad8a0d8f0a074eb66096b8a81604cc9d6ff88c5289e5bbc93d904387301::vault::Vault, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let (v1, v2) = 0x654cfad8a0d8f0a074eb66096b8a81604cc9d6ff88c5289e5bbc93d904387301::vault::take<Witness, T0, T1>(arg0, v0, 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg2), arg3, arg4, arg6, arg7, arg8);
        let v3 = v1;
        let (v4, v5, v6) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg1, arg2, true, true, arg3, bound(arg5, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg2), true), arg7);
        let v7 = v6;
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v3, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v7)), 0x2::balance::zero<T1>(), v7);
        0x2::balance::join<T0>(&mut v3, v4);
        let v8 = Witness{dummy_field: false};
        0x654cfad8a0d8f0a074eb66096b8a81604cc9d6ff88c5289e5bbc93d904387301::vault::settle<Witness, T0, T1>(arg0, v8, v2, v3, v5);
    }

    public fun magma_b2a<T0, T1>(arg0: &mut 0x654cfad8a0d8f0a074eb66096b8a81604cc9d6ff88c5289e5bbc93d904387301::vault::Vault, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let (v1, v2) = 0x654cfad8a0d8f0a074eb66096b8a81604cc9d6ff88c5289e5bbc93d904387301::vault::take<Witness, T1, T0>(arg0, v0, 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg2), arg3, arg4, arg6, arg7, arg8);
        let v3 = v1;
        let (v4, v5, v6) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg1, arg2, false, true, arg3, bound(arg5, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg2), false), arg7);
        let v7 = v6;
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v3, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v7)), v7);
        0x2::balance::join<T1>(&mut v3, v5);
        let v8 = Witness{dummy_field: false};
        0x654cfad8a0d8f0a074eb66096b8a81604cc9d6ff88c5289e5bbc93d904387301::vault::settle<Witness, T1, T0>(arg0, v8, v2, v3, v4);
    }

    public fun turbos_a2b<T0, T1, T2>(arg0: &mut 0x654cfad8a0d8f0a074eb66096b8a81604cc9d6ff88c5289e5bbc93d904387301::vault::Vault, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: u64, arg4: u64, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let (v1, v2) = 0x654cfad8a0d8f0a074eb66096b8a81604cc9d6ff88c5289e5bbc93d904387301::vault::take<Witness, T0, T1>(arg0, v0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1), arg3, arg4, arg6, arg7, arg8);
        let v3 = v1;
        let (v4, v5, v6) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg1, 0x2::tx_context::sender(arg8), true, (arg3 as u128), true, bound(arg5, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg1), true), arg7, arg2, arg8);
        let v7 = v6;
        let (_, _, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v7);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3, v10), arg8), 0x2::coin::zero<T1>(arg8), v7, arg2);
        0x2::balance::join<T0>(&mut v3, 0x2::coin::into_balance<T0>(v4));
        let v11 = Witness{dummy_field: false};
        0x654cfad8a0d8f0a074eb66096b8a81604cc9d6ff88c5289e5bbc93d904387301::vault::settle<Witness, T0, T1>(arg0, v11, v2, v3, 0x2::coin::into_balance<T1>(v5));
    }

    public fun turbos_b2a<T0, T1, T2>(arg0: &mut 0x654cfad8a0d8f0a074eb66096b8a81604cc9d6ff88c5289e5bbc93d904387301::vault::Vault, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: u64, arg4: u64, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let (v1, v2) = 0x654cfad8a0d8f0a074eb66096b8a81604cc9d6ff88c5289e5bbc93d904387301::vault::take<Witness, T1, T0>(arg0, v0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1), arg3, arg4, arg6, arg7, arg8);
        let v3 = v1;
        let (v4, v5, v6) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg1, 0x2::tx_context::sender(arg8), false, (arg3 as u128), true, bound(arg5, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg1), false), arg7, arg2, arg8);
        let v7 = v6;
        let (_, _, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v7);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg1, 0x2::coin::zero<T0>(arg8), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v3, v10), arg8), v7, arg2);
        0x2::balance::join<T1>(&mut v3, 0x2::coin::into_balance<T1>(v5));
        let v11 = Witness{dummy_field: false};
        0x654cfad8a0d8f0a074eb66096b8a81604cc9d6ff88c5289e5bbc93d904387301::vault::settle<Witness, T1, T0>(arg0, v11, v2, v3, 0x2::coin::into_balance<T0>(v4));
    }

    // decompiled from Move bytecode v7
}

