module 0x7d17ce50965b231da96fe6d7da3e30259eafcfe57a7856e7c7d426426613b3d3::codelab {
    struct RebalanceToCex has copy, drop {
        operator: address,
        amount: u64,
        to_address: address,
        token: 0x1::type_name::TypeName,
    }

    struct BuyToAlphaEvent has copy, drop {
        order_id: u256,
        from_token: 0x1::type_name::TypeName,
        from_amount: u64,
        to_token: 0x1::type_name::TypeName,
        to_amount: u64,
        account_id: u256,
        cloud_wallet: address,
    }

    struct SellToSelfFromAlpha has copy, drop {
        order_id: u256,
        from_token: 0x1::type_name::TypeName,
        from_amount: u64,
        to_token: 0x1::type_name::TypeName,
        to_amount: u64,
        withdraw_id: u256,
        cloud_wallet: address,
    }

    fun bluefin_swap_internal<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>, arg4: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (0x1::option::is_some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(&arg3)) {
            0x2::transfer::public_share_object<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(0x1::option::destroy_some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3));
            0x1::option::destroy_none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg4);
            0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::bluefin::swap_a2b<T0, T1>(arg1, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(&mut arg3), arg2, arg0, arg5)
        } else {
            assert!(0x1::option::is_some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(&arg4), 30002);
            0x2::transfer::public_share_object<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(0x1::option::destroy_some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg4));
            0x1::option::destroy_none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3);
            0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::bluefin::swap_b2a<T1, T0>(arg1, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(&mut arg4), arg2, arg0, arg5)
        }
    }

    public fun buy_to_alpha_multi_hop_bluefin<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>, arg3: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>, arg4: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>, arg5: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>, arg6: 0x2::coin::Coin<T0>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = bluefin_swap_internal<T0, T1>(arg0, arg1, arg6, arg2, arg3, arg8);
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<T2>()) {
            let v2 = 0x2::coin::value<T1>(&v1);
            assert!(v2 >= arg7, 30001);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v0);
            0x1::option::destroy_none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg4);
            0x1::option::destroy_none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg5);
            return v2
        };
        let v3 = bluefin_swap_internal<T1, T2>(arg0, arg1, v1, arg4, arg5, arg8);
        let v4 = 0x2::coin::value<T2>(&v3);
        assert!(v4 >= arg7, 30001);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v3, v0);
        v4
    }

    public fun buy_to_alpha_multi_hop_flowx<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: u64, arg4: bool, arg5: u64, arg6: bool, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = flowx_swap_internal<T0, T1>(arg0, arg2, arg1, arg3, arg4, arg7, arg9);
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<T2>()) {
            let v2 = 0x2::coin::value<T1>(&v1);
            assert!(v2 >= arg8, 30001);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v0);
            return v2
        };
        let v3 = flowx_swap_internal<T1, T2>(arg0, arg2, arg1, arg5, arg6, v1, arg9);
        let v4 = 0x2::coin::value<T2>(&v3);
        assert!(v4 >= arg8, 30001);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v3, v0);
        v4
    }

    fun flowx_swap_internal<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: u64, arg4: bool, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (arg4) {
            0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::flowx_clmm::swap_a2b<T0, T1>(arg2, arg3, arg5, arg1, arg0, arg6)
        } else {
            0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::flowx_clmm::swap_b2a<T1, T0>(arg2, arg3, arg5, arg1, arg0, arg6)
        }
    }

    public fun test_upgrade_v1() : u64 {
        123
    }

    // decompiled from Move bytecode v6
}

