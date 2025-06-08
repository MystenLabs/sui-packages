module 0x811f8080f8af494a38d46a42101475255bb74b0091dafb4a69caf55a22cc34c5::codelab {
    struct Global has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        vault_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        vault_bag: 0x2::bag::Bag,
    }

    struct SwapEvent has copy, drop {
        sender: address,
        from_coin: 0x1::type_name::TypeName,
        from_amount: u64,
        middle_coin: 0x1::type_name::TypeName,
        middle_amount: u64,
        gas_fee: u64,
        profit: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id        : 0x2::object::new(arg0),
            version   : 0,
            admin     : 0x2::tx_context::sender(arg0),
            vault_sui : 0x2::balance::zero<0x2::sui::SUI>(),
            vault_bag : 0x2::bag::new(arg0),
        };
        0x2::transfer::public_share_object<Global>(v0);
    }

    public(friend) fun only_admin(arg0: &Global, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 30002);
    }

    public(friend) fun only_allow_version(arg0: &Global) {
        assert!(arg0.version <= 0, 30000);
    }

    public fun set_conf_version(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        arg0.version = arg1;
    }

    public fun swap_bluefin_cetus_not_same_by_sui<T0>(arg0: &0x2::clock::Clock, arg1: &mut Global, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg7: 0x2::balance::Balance<0x2::sui::SUI>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, u64) {
        only_allow_version(arg1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg7);
        let v1 = (((v0 as u128) * 10006 / 10000) as u64);
        let v2 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::bluefin::swap_a2b<0x2::sui::SUI, T0>(arg5, arg6, 0x2::coin::from_balance<0x2::sui::SUI>(arg7, arg9), arg0, arg9);
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_a2b<T0, 0x2::sui::SUI>(arg2, arg4, arg3, v2, arg0, arg9));
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&v3);
        let v5 = 0x2::tx_context::sender(arg9);
        assert!(v4 > v1 + arg8, 30013);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, arg8), arg9), v5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.vault_sui, v3);
        let v6 = SwapEvent{
            sender        : v5,
            from_coin     : 0x1::type_name::get<0x2::sui::SUI>(),
            from_amount   : v0,
            middle_coin   : 0x1::type_name::get<T0>(),
            middle_amount : 0x2::coin::value<T0>(&v2),
            gas_fee       : arg8,
            profit        : v4 - v1,
        };
        0x2::event::emit<SwapEvent>(v6);
        (0x2::balance::split<0x2::sui::SUI>(&mut v3, v1), v1)
    }

    public fun swap_bluefin_cetus_same_by_sui<T0>(arg0: &0x2::clock::Clock, arg1: &mut Global, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg7: 0x2::balance::Balance<0x2::sui::SUI>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, u64) {
        only_allow_version(arg1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg7);
        let v1 = (((v0 as u128) * 10006 / 10000) as u64);
        let v2 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::bluefin::swap_b2a<T0, 0x2::sui::SUI>(arg5, arg6, 0x2::coin::from_balance<0x2::sui::SUI>(arg7, arg9), arg0, arg9);
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_a2b<T0, 0x2::sui::SUI>(arg2, arg4, arg3, v2, arg0, arg9));
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&v3);
        let v5 = 0x2::tx_context::sender(arg9);
        assert!(v4 > v1 + arg8, 30013);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, arg8), arg9), v5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.vault_sui, v3);
        let v6 = SwapEvent{
            sender        : v5,
            from_coin     : 0x1::type_name::get<0x2::sui::SUI>(),
            from_amount   : v0,
            middle_coin   : 0x1::type_name::get<T0>(),
            middle_amount : 0x2::coin::value<T0>(&v2),
            gas_fee       : arg8,
            profit        : v4 - v1,
        };
        0x2::event::emit<SwapEvent>(v6);
        (0x2::balance::split<0x2::sui::SUI>(&mut v3, v1), v1)
    }

    public fun swap_cetus_bluefin_not_same_by_sui<T0>(arg0: &0x2::clock::Clock, arg1: &mut Global, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg7: 0x2::balance::Balance<0x2::sui::SUI>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, u64) {
        only_allow_version(arg1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg7);
        let v1 = (((v0 as u128) * 10006 / 10000) as u64);
        let v2 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_b2a<T0, 0x2::sui::SUI>(arg2, arg4, arg3, 0x2::coin::from_balance<0x2::sui::SUI>(arg7, arg9), arg0, arg9);
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::bluefin::swap_b2a<0x2::sui::SUI, T0>(arg5, arg6, v2, arg0, arg9));
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&v3);
        let v5 = 0x2::tx_context::sender(arg9);
        assert!(v4 > v1 + arg8, 30013);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, arg8), arg9), v5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.vault_sui, v3);
        let v6 = SwapEvent{
            sender        : v5,
            from_coin     : 0x1::type_name::get<0x2::sui::SUI>(),
            from_amount   : v0,
            middle_coin   : 0x1::type_name::get<T0>(),
            middle_amount : 0x2::coin::value<T0>(&v2),
            gas_fee       : arg8,
            profit        : v4 - v1,
        };
        0x2::event::emit<SwapEvent>(v6);
        (0x2::balance::split<0x2::sui::SUI>(&mut v3, v1), v1)
    }

    public fun swap_cetus_bluefin_same_by_sui<T0>(arg0: &0x2::clock::Clock, arg1: &mut Global, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg7: 0x2::balance::Balance<0x2::sui::SUI>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, u64) {
        only_allow_version(arg1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg7);
        let v1 = (((v0 as u128) * 10006 / 10000) as u64);
        let v2 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_b2a<T0, 0x2::sui::SUI>(arg2, arg4, arg3, 0x2::coin::from_balance<0x2::sui::SUI>(arg7, arg9), arg0, arg9);
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::bluefin::swap_a2b<T0, 0x2::sui::SUI>(arg5, arg6, v2, arg0, arg9));
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&v3);
        let v5 = 0x2::tx_context::sender(arg9);
        assert!(v4 > v1 + arg8, 30013);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, arg8), arg9), v5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.vault_sui, v3);
        let v6 = SwapEvent{
            sender        : v5,
            from_coin     : 0x1::type_name::get<0x2::sui::SUI>(),
            from_amount   : v0,
            middle_coin   : 0x1::type_name::get<T0>(),
            middle_amount : 0x2::coin::value<T0>(&v2),
            gas_fee       : arg8,
            profit        : v4 - v1,
        };
        0x2::event::emit<SwapEvent>(v6);
        (0x2::balance::split<0x2::sui::SUI>(&mut v3, v1), v1)
    }

    public fun test_flash(arg0: &mut Global, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, u64) {
        only_allow_version(arg0);
        let v0 = (((0x2::balance::value<0x2::sui::SUI>(&arg1) as u128) * 10006 / 10000) as u64);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(arg1, arg4));
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&v1);
        assert!(v2 > v0 + arg3, 30013);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault_sui, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v2 - v0));
        (v1, v0)
    }

    public fun test_swap<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, u64) {
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(arg3, arg5);
        let v1 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::bluefin::swap_a2b<0x2::sui::SUI, T0>(arg1, arg2, v0, arg0, arg5);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::bluefin::swap_b2a<0x2::sui::SUI, T0>(arg1, arg2, v1, arg0, arg5));
        let v3 = SwapEvent{
            sender        : 0x2::tx_context::sender(arg5),
            from_coin     : 0x1::type_name::get<0x2::sui::SUI>(),
            from_amount   : 0x2::coin::value<0x2::sui::SUI>(&v0),
            middle_coin   : 0x1::type_name::get<T0>(),
            middle_amount : 0x2::coin::value<T0>(&v1),
            gas_fee       : arg4,
            profit        : 0,
        };
        0x2::event::emit<SwapEvent>(v3);
        (v2, 0x2::balance::value<0x2::sui::SUI>(&v2))
    }

    // decompiled from Move bytecode v6
}

