module 0x220a227dfec7e67c65f628650ad1390699af279f01b6e43b088a12523ff8e6b4::codelab {
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

    struct Event_v1 has copy, drop {
        x: u64,
    }

    struct Event_v2 has copy, drop {
        x: u64,
    }

    struct Swaping {
        from_coin_type: 0x1::type_name::TypeName,
        total_from_amount: u64,
        remaining_from_amount: u64,
        to_coin_type: 0x1::type_name::TypeName,
        accumulated_to_amount: u64,
        min_to_amount: u64,
        middle_coin_type: 0x1::type_name::TypeName,
        middle_amount: u64,
    }

    public fun after_swap<T0>(arg0: 0x2::coin::Coin<T0>, arg1: Swaping, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let Swaping {
            from_coin_type        : _,
            total_from_amount     : _,
            remaining_from_amount : v2,
            to_coin_type          : v3,
            accumulated_to_amount : v4,
            min_to_amount         : v5,
            middle_coin_type      : _,
            middle_amount         : v7,
        } = arg1;
        assert!(v3 == 0x1::type_name::get<T0>(), 30005);
        assert!(v2 == 0, 30006);
        let v8 = 0x2::coin::value<T0>(&arg0);
        assert!(v4 == v8, 30007);
        assert!(v8 >= v5, 30001);
        assert!(v7 == 0, 30008);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
        v8
    }

    public fun before_buy<T0, T1>(arg0: u64, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Swaping) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = Swaping{
            from_coin_type        : v0,
            total_from_amount     : arg0,
            remaining_from_amount : arg0,
            to_coin_type          : 0x1::type_name::get<T1>(),
            accumulated_to_amount : 0,
            min_to_amount         : arg1,
            middle_coin_type      : v0,
            middle_amount         : 0,
        };
        (arg2, v1)
    }

    public fun bluefin_swap_a2b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: Swaping, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, Swaping) {
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::bluefin::swap_a2b<T0, T1>(arg1, arg2, arg3, arg0, arg5);
        let v1 = &mut arg4;
        update_swaping<T0, T1>(v1, 0x2::coin::value<T0>(&arg3), 0x2::coin::value<T1>(&v0));
        (v0, arg4)
    }

    public fun bluefin_swap_b2a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: Swaping, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Swaping) {
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::bluefin::swap_b2a<T0, T1>(arg1, arg2, arg3, arg0, arg5);
        let v1 = &mut arg4;
        update_swaping<T1, T0>(v1, 0x2::coin::value<T1>(&arg3), 0x2::coin::value<T0>(&v0));
        (v0, arg4)
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

    public fun cetus_swap_a2b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: Swaping, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, Swaping) {
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_a2b<T0, T1>(arg1, arg3, arg2, arg4, arg0, arg6);
        let v1 = &mut arg5;
        update_swaping<T0, T1>(v1, 0x2::coin::value<T0>(&arg4), 0x2::coin::value<T1>(&v0));
        (v0, arg5)
    }

    public fun cetus_swap_b2a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T1>, arg5: Swaping, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Swaping) {
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_b2a<T0, T1>(arg1, arg3, arg2, arg4, arg0, arg6);
        let v1 = &mut arg5;
        update_swaping<T1, T0>(v1, 0x2::coin::value<T1>(&arg4), 0x2::coin::value<T0>(&v0));
        (v0, arg5)
    }

    public fun flowx_swap_a2b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: Swaping, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, Swaping) {
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::flowx_clmm::swap_a2b<T0, T1>(arg2, arg3, arg4, arg1, arg0, arg6);
        let v1 = &mut arg5;
        update_swaping<T0, T1>(v1, 0x2::coin::value<T0>(&arg4), 0x2::coin::value<T1>(&v0));
        (v0, arg5)
    }

    public fun flowx_swap_b2a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: Swaping, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Swaping) {
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::flowx_clmm::swap_b2a<T0, T1>(arg2, arg3, arg4, arg1, arg0, arg6);
        let v1 = &mut arg5;
        update_swaping<T1, T0>(v1, 0x2::coin::value<T1>(&arg4), 0x2::coin::value<T0>(&v0));
        (v0, arg5)
    }

    fun flowx_swap_internal<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: u64, arg4: bool, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (arg4) {
            0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::flowx_clmm::swap_a2b<T0, T1>(arg2, arg3, arg5, arg1, arg0, arg6)
        } else {
            0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::flowx_clmm::swap_b2a<T1, T0>(arg2, arg3, arg5, arg1, arg0, arg6)
        }
    }

    public fun test_u8() : u8 {
        12
    }

    public fun test_upgrade_v1() : u64 {
        let v0 = Event_v1{x: 111};
        0x2::event::emit<Event_v1>(v0);
        123
    }

    public fun test_upgrade_v2() : u64 {
        let v0 = Event_v2{x: 222};
        0x2::event::emit<Event_v2>(v0);
        222
    }

    fun update_swaping<T0, T1>(arg0: &mut Swaping, arg1: u64, arg2: u64) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(v0 != v1, 30009);
        assert!(v1 != arg0.from_coin_type, 30005);
        assert!(v0 != arg0.to_coin_type, 30010);
        if (v0 == arg0.from_coin_type) {
            arg0.remaining_from_amount = arg0.remaining_from_amount - arg1;
        } else {
            assert!(v0 == arg0.middle_coin_type, 30011);
            assert!(arg1 == arg0.middle_amount, 30012);
            arg0.middle_amount = 0;
        };
        assert!(arg0.middle_amount == 0, 30008);
        if (v1 == arg0.to_coin_type) {
            arg0.accumulated_to_amount = arg0.accumulated_to_amount + arg2;
        } else {
            arg0.middle_coin_type = v1;
            arg0.middle_amount = arg2;
        };
    }

    // decompiled from Move bytecode v6
}

