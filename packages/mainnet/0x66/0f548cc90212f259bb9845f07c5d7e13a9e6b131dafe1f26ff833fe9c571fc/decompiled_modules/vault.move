module 0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault {
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

    public fun buy_to_alpha<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::VaultConfig, arg2: &mut 0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::VaultTokenHolder, arg3: &0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet_config::CloudWalletConfig, arg4: &mut 0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet_config::CloudWalletTokenHolder, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg8: u256, arg9: u256, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        if (0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::coin_a_is_whitelist<T0, T1>(arg1)) {
            swap_check<T0>(arg0, arg1, arg12, arg10, arg13);
            let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_a2b<T0, T1>(arg5, arg6, arg7, 0x2::coin::from_balance<T0>(0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::get_token_to_vault<T0>(arg2, arg10), arg13), arg0, arg13);
            let v1 = 0x2::coin::value<T1>(&v0);
            assert!(v1 >= arg11, 30001);
            let v2 = BuyToAlphaEvent{
                order_id     : arg8,
                from_token   : 0x1::type_name::get<T0>(),
                from_amount  : arg10,
                to_token     : 0x1::type_name::get<T1>(),
                to_amount    : v1,
                account_id   : arg9,
                cloud_wallet : @0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee,
            };
            0x2::event::emit<BuyToAlphaEvent>(v2);
            0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet::deposit<T1>(arg3, arg4, 0x2::coin::into_balance<T1>(v0), arg8, arg9, get_checksum<T0>(arg10, arg12), arg13);
        } else {
            swap_check<T1>(arg0, arg1, arg12, arg10, arg13);
            let v3 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_b2a<T0, T1>(arg5, arg6, arg7, 0x2::coin::from_balance<T1>(0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::get_token_to_vault<T1>(arg2, arg10), arg13), arg0, arg13);
            let v4 = 0x2::coin::value<T0>(&v3);
            assert!(v4 >= arg11, 30001);
            let v5 = BuyToAlphaEvent{
                order_id     : arg8,
                from_token   : 0x1::type_name::get<T1>(),
                from_amount  : arg10,
                to_token     : 0x1::type_name::get<T0>(),
                to_amount    : v4,
                account_id   : arg9,
                cloud_wallet : @0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee,
            };
            0x2::event::emit<BuyToAlphaEvent>(v5);
            0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet::deposit<T0>(arg3, arg4, 0x2::coin::into_balance<T0>(v3), arg8, arg9, get_checksum<T1>(arg10, arg12), arg13);
        };
    }

    public fun buy_to_alpha_multi_hop<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::VaultConfig, arg2: &mut 0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::VaultTokenHolder, arg3: &0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet_config::CloudWalletConfig, arg4: &mut 0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet_config::CloudWalletTokenHolder, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg7: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>, arg8: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>, arg9: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>, arg10: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>, arg11: u256, arg12: u256, arg13: u64, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) : u64 {
        swap_check<T0>(arg0, arg1, arg15, arg13, arg16);
        let v0 = 0x2::coin::from_balance<T0>(0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::get_token_to_vault<T0>(arg2, arg13), arg16);
        let v1 = cetus_swap_internal<T0, T1>(arg0, arg5, arg6, v0, arg7, arg8, arg16);
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<T2>()) {
            let v2 = 0x2::coin::value<T1>(&v1);
            assert!(v2 >= arg14, 30001);
            let v3 = BuyToAlphaEvent{
                order_id     : arg11,
                from_token   : 0x1::type_name::get<T0>(),
                from_amount  : arg13,
                to_token     : 0x1::type_name::get<T1>(),
                to_amount    : v2,
                account_id   : arg12,
                cloud_wallet : @0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee,
            };
            0x2::event::emit<BuyToAlphaEvent>(v3);
            0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet::deposit<T1>(arg3, arg4, 0x2::coin::into_balance<T1>(v1), arg11, arg12, get_checksum<T0>(arg13, arg15), arg16);
            0x1::option::destroy_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg9);
            0x1::option::destroy_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg10);
            return v2
        };
        let v4 = cetus_swap_internal<T1, T2>(arg0, arg5, arg6, v1, arg9, arg10, arg16);
        let v5 = 0x2::coin::value<T2>(&v4);
        assert!(v5 >= arg14, 30001);
        let v6 = BuyToAlphaEvent{
            order_id     : arg11,
            from_token   : 0x1::type_name::get<T0>(),
            from_amount  : arg13,
            to_token     : 0x1::type_name::get<T2>(),
            to_amount    : v5,
            account_id   : arg12,
            cloud_wallet : @0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee,
        };
        0x2::event::emit<BuyToAlphaEvent>(v6);
        0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet::deposit<T2>(arg3, arg4, 0x2::coin::into_balance<T2>(v4), arg11, arg12, get_checksum<T0>(arg13, arg15), arg16);
        v5
    }

    public fun buy_to_alpha_multi_hop_bluefin<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::VaultConfig, arg2: &mut 0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::VaultTokenHolder, arg3: &0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet_config::CloudWalletConfig, arg4: &mut 0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet_config::CloudWalletTokenHolder, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>, arg7: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>, arg8: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>, arg9: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>, arg10: u256, arg11: u256, arg12: u64, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) : u64 {
        swap_check<T0>(arg0, arg1, arg14, arg12, arg15);
        let v0 = 0x2::coin::from_balance<T0>(0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::get_token_to_vault<T0>(arg2, arg12), arg15);
        let v1 = bluefin_swap_internal<T0, T1>(arg0, arg5, v0, arg6, arg7, arg15);
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<T2>()) {
            let v2 = 0x2::coin::value<T1>(&v1);
            assert!(v2 >= arg13, 30001);
            let v3 = BuyToAlphaEvent{
                order_id     : arg10,
                from_token   : 0x1::type_name::get<T0>(),
                from_amount  : arg12,
                to_token     : 0x1::type_name::get<T1>(),
                to_amount    : v2,
                account_id   : arg11,
                cloud_wallet : @0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee,
            };
            0x2::event::emit<BuyToAlphaEvent>(v3);
            0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet::deposit<T1>(arg3, arg4, 0x2::coin::into_balance<T1>(v1), arg10, arg11, get_checksum<T0>(arg12, arg14), arg15);
            0x1::option::destroy_none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg8);
            0x1::option::destroy_none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg9);
            return v2
        };
        let v4 = bluefin_swap_internal<T1, T2>(arg0, arg5, v1, arg8, arg9, arg15);
        let v5 = 0x2::coin::value<T2>(&v4);
        assert!(v5 >= arg13, 30001);
        let v6 = BuyToAlphaEvent{
            order_id     : arg10,
            from_token   : 0x1::type_name::get<T0>(),
            from_amount  : arg12,
            to_token     : 0x1::type_name::get<T2>(),
            to_amount    : v5,
            account_id   : arg11,
            cloud_wallet : @0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee,
        };
        0x2::event::emit<BuyToAlphaEvent>(v6);
        0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet::deposit<T2>(arg3, arg4, 0x2::coin::into_balance<T2>(v4), arg10, arg11, get_checksum<T0>(arg12, arg14), arg15);
        v5
    }

    public fun buy_to_alpha_multi_hop_flowx<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::VaultConfig, arg2: &mut 0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::VaultTokenHolder, arg3: &0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet_config::CloudWalletConfig, arg4: &mut 0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet_config::CloudWalletTokenHolder, arg5: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg6: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg7: u64, arg8: bool, arg9: u64, arg10: bool, arg11: u256, arg12: u256, arg13: u64, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) : u64 {
        swap_check<T0>(arg0, arg1, arg15, arg13, arg16);
        let v0 = 0x2::coin::from_balance<T0>(0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::get_token_to_vault<T0>(arg2, arg13), arg16);
        let v1 = flowx_swap_internal<T0, T1>(arg0, arg6, arg5, arg7, arg8, v0, arg16);
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<T2>()) {
            let v2 = 0x2::coin::value<T1>(&v1);
            assert!(v2 >= arg14, 30001);
            let v3 = BuyToAlphaEvent{
                order_id     : arg11,
                from_token   : 0x1::type_name::get<T0>(),
                from_amount  : arg13,
                to_token     : 0x1::type_name::get<T1>(),
                to_amount    : v2,
                account_id   : arg12,
                cloud_wallet : @0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee,
            };
            0x2::event::emit<BuyToAlphaEvent>(v3);
            0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet::deposit<T1>(arg3, arg4, 0x2::coin::into_balance<T1>(v1), arg11, arg12, get_checksum<T0>(arg13, arg15), arg16);
            return v2
        };
        let v4 = flowx_swap_internal<T1, T2>(arg0, arg6, arg5, arg9, arg10, v1, arg16);
        let v5 = 0x2::coin::value<T2>(&v4);
        assert!(v5 >= arg14, 30001);
        let v6 = BuyToAlphaEvent{
            order_id     : arg11,
            from_token   : 0x1::type_name::get<T0>(),
            from_amount  : arg13,
            to_token     : 0x1::type_name::get<T2>(),
            to_amount    : v5,
            account_id   : arg12,
            cloud_wallet : @0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee,
        };
        0x2::event::emit<BuyToAlphaEvent>(v6);
        0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet::deposit<T2>(arg3, arg4, 0x2::coin::into_balance<T2>(v4), arg11, arg12, get_checksum<T0>(arg13, arg15), arg16);
        v5
    }

    fun cetus_swap_internal<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>, arg5: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(&arg4)) {
            0x2::transfer::public_share_object<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(0x1::option::destroy_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4));
            0x1::option::destroy_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg5);
            0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_a2b<T0, T1>(arg1, 0x1::option::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(&mut arg4), arg2, arg3, arg0, arg6)
        } else {
            assert!(0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(&arg5), 30002);
            0x2::transfer::public_share_object<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(0x1::option::destroy_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg5));
            0x1::option::destroy_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4);
            0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_b2a<T1, T0>(arg1, 0x1::option::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(&mut arg5), arg2, arg3, arg0, arg6)
        }
    }

    public fun credit_coin<T0>(arg0: &0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::VaultConfig, arg1: &mut 0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::VaultTokenHolder, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg3: &mut 0x2::tx_context::TxContext) {
        0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::only_operator(arg0, arg3);
        0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::only_allow_version(arg0);
        0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::credit_coin<T0>(arg1, arg2, arg3);
    }

    public fun emergency_withdraw<T0>(arg0: &0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::VaultConfig, arg1: &mut 0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::VaultTokenHolder, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::only_admin(arg0, arg4);
        0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::only_allow_version(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::emergency_withdraw<T0>(arg1, arg2), arg4), arg3);
    }

    fun flowx_swap_internal<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: u64, arg4: bool, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (arg4) {
            0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::flowx_clmm::swap_a2b<T0, T1>(arg2, arg3, arg5, arg1, arg0, arg6)
        } else {
            0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::flowx_clmm::swap_b2a<T1, T0>(arg2, arg3, arg5, arg1, arg0, arg6)
        }
    }

    public(friend) fun get_checksum<T0>(arg0: u64, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg0 as u256))));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256(((arg1 / 1000) as u256))));
        0x2::hash::keccak256(&v0)
    }

    public fun rebalance_out<T0>(arg0: &0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::VaultConfig, arg1: &mut 0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::VaultTokenHolder, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::only_operator(arg0, arg4);
        0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::only_allow_version(arg0);
        0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::check_rebalance_to(arg0, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::rebalance_out<T0>(arg1, arg3), arg4), arg2);
        let v0 = RebalanceToCex{
            operator   : 0x2::tx_context::sender(arg4),
            amount     : arg3,
            to_address : arg2,
            token      : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<RebalanceToCex>(v0);
    }

    public fun sell_to_self_from_alpha<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::VaultConfig, arg2: &mut 0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::VaultTokenHolder, arg3: &mut 0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet_config::CloudWalletConfig, arg4: &mut 0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet_config::CloudWalletTokenHolder, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg8: u256, arg9: u256, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) : u64 {
        if (0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::coin_a_is_whitelist<T0, T1>(arg1)) {
            swap_check<T0>(arg0, arg1, arg12, 0, arg14);
            let v1 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_b2a<T0, T1>(arg5, arg6, arg7, 0x2::coin::from_balance<T1>(0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet::quick_withdraw<T1>(0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::borrow_withdraw_cap(arg2), arg3, arg4, arg0, arg9, arg10, arg13), arg14), arg0, arg14);
            let v2 = 0x2::coin::value<T0>(&v1);
            assert!(v2 >= arg11, 30001);
            let v3 = SellToSelfFromAlpha{
                order_id     : arg8,
                from_token   : 0x1::type_name::get<T1>(),
                from_amount  : arg10,
                to_token     : 0x1::type_name::get<T0>(),
                to_amount    : v2,
                withdraw_id  : arg9,
                cloud_wallet : @0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee,
            };
            0x2::event::emit<SellToSelfFromAlpha>(v3);
            0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::deposit_token_from_vault<T0>(arg2, v1);
            v2
        } else {
            swap_check<T1>(arg0, arg1, arg12, 0, arg14);
            let v4 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_a2b<T0, T1>(arg5, arg6, arg7, 0x2::coin::from_balance<T0>(0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet::quick_withdraw<T0>(0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::borrow_withdraw_cap(arg2), arg3, arg4, arg0, arg9, arg10, arg13), arg14), arg0, arg14);
            let v5 = 0x2::coin::value<T1>(&v4);
            assert!(v5 >= arg11, 30001);
            let v6 = SellToSelfFromAlpha{
                order_id     : arg8,
                from_token   : 0x1::type_name::get<T0>(),
                from_amount  : arg10,
                to_token     : 0x1::type_name::get<T1>(),
                to_amount    : v5,
                withdraw_id  : arg9,
                cloud_wallet : @0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee,
            };
            0x2::event::emit<SellToSelfFromAlpha>(v6);
            0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::deposit_token_from_vault<T1>(arg2, v4);
            v5
        }
    }

    public fun sell_to_self_from_alpha_multi_hop<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::VaultConfig, arg2: &mut 0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::VaultTokenHolder, arg3: &mut 0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet_config::CloudWalletConfig, arg4: &mut 0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet_config::CloudWalletTokenHolder, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg7: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>, arg8: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>, arg9: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>, arg10: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>, arg11: u256, arg12: u256, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) : u64 {
        swap_check<T2>(arg0, arg1, arg15, 0, arg17);
        let v0 = 0x2::coin::from_balance<T0>(0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet::quick_withdraw<T0>(0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::borrow_withdraw_cap(arg2), arg3, arg4, arg0, arg12, arg13, arg16), arg17);
        let v1 = cetus_swap_internal<T0, T1>(arg0, arg5, arg6, v0, arg7, arg8, arg17);
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<T2>()) {
            let v2 = 0x2::coin::value<T1>(&v1);
            assert!(v2 >= arg14, 30001);
            let v3 = SellToSelfFromAlpha{
                order_id     : arg11,
                from_token   : 0x1::type_name::get<T0>(),
                from_amount  : arg13,
                to_token     : 0x1::type_name::get<T1>(),
                to_amount    : v2,
                withdraw_id  : arg12,
                cloud_wallet : @0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee,
            };
            0x2::event::emit<SellToSelfFromAlpha>(v3);
            0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::deposit_token_from_vault<T1>(arg2, v1);
            0x1::option::destroy_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg9);
            0x1::option::destroy_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg10);
            return v2
        };
        let v4 = cetus_swap_internal<T1, T2>(arg0, arg5, arg6, v1, arg9, arg10, arg17);
        let v5 = 0x2::coin::value<T2>(&v4);
        assert!(v5 >= arg14, 30001);
        let v6 = SellToSelfFromAlpha{
            order_id     : arg11,
            from_token   : 0x1::type_name::get<T0>(),
            from_amount  : arg13,
            to_token     : 0x1::type_name::get<T2>(),
            to_amount    : v5,
            withdraw_id  : arg12,
            cloud_wallet : @0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee,
        };
        0x2::event::emit<SellToSelfFromAlpha>(v6);
        0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::deposit_token_from_vault<T2>(arg2, v4);
        v5
    }

    public fun sell_to_self_from_alpha_multi_hop_bluefin<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::VaultConfig, arg2: &mut 0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::VaultTokenHolder, arg3: &mut 0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet_config::CloudWalletConfig, arg4: &mut 0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet_config::CloudWalletTokenHolder, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>, arg7: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>, arg8: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>, arg9: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>, arg10: u256, arg11: u256, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) : u64 {
        swap_check<T2>(arg0, arg1, arg14, 0, arg16);
        let v0 = 0x2::coin::from_balance<T0>(0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet::quick_withdraw<T0>(0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::borrow_withdraw_cap(arg2), arg3, arg4, arg0, arg11, arg12, arg15), arg16);
        let v1 = bluefin_swap_internal<T0, T1>(arg0, arg5, v0, arg6, arg7, arg16);
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<T2>()) {
            let v2 = 0x2::coin::value<T1>(&v1);
            assert!(v2 >= arg13, 30001);
            let v3 = SellToSelfFromAlpha{
                order_id     : arg10,
                from_token   : 0x1::type_name::get<T0>(),
                from_amount  : arg12,
                to_token     : 0x1::type_name::get<T1>(),
                to_amount    : v2,
                withdraw_id  : arg11,
                cloud_wallet : @0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee,
            };
            0x2::event::emit<SellToSelfFromAlpha>(v3);
            0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::deposit_token_from_vault<T1>(arg2, v1);
            0x1::option::destroy_none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg8);
            0x1::option::destroy_none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg9);
            return v2
        };
        let v4 = bluefin_swap_internal<T1, T2>(arg0, arg5, v1, arg8, arg9, arg16);
        let v5 = 0x2::coin::value<T2>(&v4);
        assert!(v5 >= arg13, 30001);
        let v6 = SellToSelfFromAlpha{
            order_id     : arg10,
            from_token   : 0x1::type_name::get<T0>(),
            from_amount  : arg12,
            to_token     : 0x1::type_name::get<T2>(),
            to_amount    : v5,
            withdraw_id  : arg11,
            cloud_wallet : @0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee,
        };
        0x2::event::emit<SellToSelfFromAlpha>(v6);
        0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::deposit_token_from_vault<T2>(arg2, v4);
        v5
    }

    public fun sell_to_self_from_alpha_multi_hop_flowx<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::VaultConfig, arg2: &mut 0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::VaultTokenHolder, arg3: &mut 0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet_config::CloudWalletConfig, arg4: &mut 0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet_config::CloudWalletTokenHolder, arg5: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg6: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg7: u64, arg8: bool, arg9: u64, arg10: bool, arg11: u256, arg12: u256, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) : u64 {
        swap_check<T2>(arg0, arg1, arg15, 0, arg17);
        let v0 = 0x2::coin::from_balance<T0>(0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee::cloud_wallet::quick_withdraw<T0>(0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::borrow_withdraw_cap(arg2), arg3, arg4, arg0, arg12, arg13, arg16), arg17);
        let v1 = flowx_swap_internal<T0, T1>(arg0, arg6, arg5, arg7, arg8, v0, arg17);
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<T2>()) {
            let v2 = 0x2::coin::value<T1>(&v1);
            assert!(v2 >= arg14, 30001);
            let v3 = SellToSelfFromAlpha{
                order_id     : arg11,
                from_token   : 0x1::type_name::get<T0>(),
                from_amount  : arg13,
                to_token     : 0x1::type_name::get<T1>(),
                to_amount    : v2,
                withdraw_id  : arg12,
                cloud_wallet : @0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee,
            };
            0x2::event::emit<SellToSelfFromAlpha>(v3);
            0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::deposit_token_from_vault<T1>(arg2, v1);
            return v2
        };
        let v4 = flowx_swap_internal<T1, T2>(arg0, arg6, arg5, arg9, arg10, v1, arg17);
        let v5 = 0x2::coin::value<T2>(&v4);
        assert!(v5 >= arg14, 30001);
        let v6 = SellToSelfFromAlpha{
            order_id     : arg11,
            from_token   : 0x1::type_name::get<T0>(),
            from_amount  : arg13,
            to_token     : 0x1::type_name::get<T2>(),
            to_amount    : v5,
            withdraw_id  : arg12,
            cloud_wallet : @0x75f575353687734ab7c5910566fdb59e0c04e4fcffdf46c83fad8bc1b71450ee,
        };
        0x2::event::emit<SellToSelfFromAlpha>(v6);
        0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::deposit_token_from_vault<T2>(arg2, v4);
        v5
    }

    public fun swap_check<T0>(arg0: &0x2::clock::Clock, arg1: &0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::VaultConfig, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::only_trusted_bot(arg1, arg4);
        0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::when_not_paused(arg1);
        0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::when_not_expired(arg0, arg2);
        0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::check_trade_token<T0>(arg1, arg3);
        0x660f548cc90212f259bb9845f07c5d7e13a9e6b131dafe1f26ff833fe9c571fc::vault_config::only_allow_version(arg1);
    }

    // decompiled from Move bytecode v6
}

