module 0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault {
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

    struct Swaping {
        order_id: u256,
        account_id: u256,
        checksum: vector<u8>,
        from_coin_type: 0x1::type_name::TypeName,
        total_from_amount: u64,
        remaining_from_amount: u64,
        to_coin_type: 0x1::type_name::TypeName,
        accumulated_to_amount: u64,
        min_to_amount: u64,
        middle_coin_type: 0x1::type_name::TypeName,
        middle_amount: u64,
    }

    public fun after_swap<T0>(arg0: &mut 0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::VaultConfig, arg1: &0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet_config::CloudWalletConfig, arg2: &mut 0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet_config::CloudWalletTokenHolder, arg3: 0x2::coin::Coin<T0>, arg4: Swaping, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        let Swaping {
            order_id              : v0,
            account_id            : v1,
            checksum              : v2,
            from_coin_type        : v3,
            total_from_amount     : v4,
            remaining_from_amount : v5,
            to_coin_type          : v6,
            accumulated_to_amount : v7,
            min_to_amount         : v8,
            middle_coin_type      : _,
            middle_amount         : v10,
        } = arg4;
        assert!(v6 == 0x1::type_name::get<T0>(), 30005);
        assert!(v5 == 0, 30006);
        let v11 = 0x2::coin::value<T0>(&arg3);
        assert!(v7 == v11, 30007);
        assert!(v11 >= v8, 30001);
        assert!(v10 == 0, 30008);
        let v12 = 0x2::object::id<0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet_config::CloudWalletTokenHolder>(arg2);
        let v13 = BuyToAlphaEvent{
            order_id     : v0,
            from_token   : v3,
            from_amount  : v4,
            to_token     : v6,
            to_amount    : v11,
            account_id   : v1,
            cloud_wallet : 0x2::object::id_to_address(&v12),
        };
        0x2::event::emit<BuyToAlphaEvent>(v13);
        0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet::deposit<T0>(arg1, arg2, 0x2::coin::into_balance<T0>(arg3), v0, v1, v2, arg5);
        0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::mark_order_id_used(arg0, v0);
        v11
    }

    public fun before_buy<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::VaultConfig, arg2: &mut 0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::VaultTokenHolder, arg3: u64, arg4: u64, arg5: u256, arg6: u256, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Swaping) {
        swap_check<T0>(arg0, arg1, arg7, arg3, arg5, arg8);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = Swaping{
            order_id              : arg5,
            account_id            : arg6,
            checksum              : get_checksum<T0>(arg3, arg7),
            from_coin_type        : v0,
            total_from_amount     : arg3,
            remaining_from_amount : arg3,
            to_coin_type          : 0x1::type_name::get<T1>(),
            accumulated_to_amount : 0,
            min_to_amount         : arg4,
            middle_coin_type      : v0,
            middle_amount         : 0,
        };
        (0x2::coin::from_balance<T0>(0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::get_token_to_vault<T0>(arg2, arg3), arg8), v1)
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

    public fun buy_to_alpha_multi_hop_bluefin<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::VaultConfig, arg2: &mut 0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::VaultTokenHolder, arg3: &0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet_config::CloudWalletConfig, arg4: &mut 0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet_config::CloudWalletTokenHolder, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>, arg7: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>, arg8: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>, arg9: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>, arg10: u256, arg11: u256, arg12: u64, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) : u64 {
        swap_check<T0>(arg0, arg1, arg14, arg12, arg10, arg15);
        let v0 = 0x2::coin::from_balance<T0>(0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::get_token_to_vault<T0>(arg2, arg12), arg15);
        let v1 = bluefin_swap_internal<T0, T1>(arg0, arg5, v0, arg6, arg7, arg15);
        let v2 = 0x2::object::id<0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet_config::CloudWalletTokenHolder>(arg4);
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<T2>()) {
            let v3 = 0x2::coin::value<T1>(&v1);
            assert!(v3 >= arg13, 30001);
            let v4 = BuyToAlphaEvent{
                order_id     : arg10,
                from_token   : 0x1::type_name::get<T0>(),
                from_amount  : arg12,
                to_token     : 0x1::type_name::get<T1>(),
                to_amount    : v3,
                account_id   : arg11,
                cloud_wallet : 0x2::object::id_to_address(&v2),
            };
            0x2::event::emit<BuyToAlphaEvent>(v4);
            0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet::deposit<T1>(arg3, arg4, 0x2::coin::into_balance<T1>(v1), arg10, arg11, get_checksum<T0>(arg12, arg14), arg15);
            0x1::option::destroy_none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg8);
            0x1::option::destroy_none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg9);
            0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::mark_order_id_used(arg1, arg10);
            return v3
        };
        let v5 = bluefin_swap_internal<T1, T2>(arg0, arg5, v1, arg8, arg9, arg15);
        let v6 = 0x2::coin::value<T2>(&v5);
        assert!(v6 >= arg13, 30001);
        let v7 = BuyToAlphaEvent{
            order_id     : arg10,
            from_token   : 0x1::type_name::get<T0>(),
            from_amount  : arg12,
            to_token     : 0x1::type_name::get<T2>(),
            to_amount    : v6,
            account_id   : arg11,
            cloud_wallet : 0x2::object::id_to_address(&v2),
        };
        0x2::event::emit<BuyToAlphaEvent>(v7);
        0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet::deposit<T2>(arg3, arg4, 0x2::coin::into_balance<T2>(v5), arg10, arg11, get_checksum<T0>(arg12, arg14), arg15);
        0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::mark_order_id_used(arg1, arg10);
        v6
    }

    public fun buy_to_alpha_multi_hop_cetus<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::VaultConfig, arg2: &mut 0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::VaultTokenHolder, arg3: &0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet_config::CloudWalletConfig, arg4: &mut 0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet_config::CloudWalletTokenHolder, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg7: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>, arg8: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>, arg9: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>, arg10: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>, arg11: u256, arg12: u256, arg13: u64, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) : u64 {
        swap_check<T0>(arg0, arg1, arg15, arg13, arg11, arg16);
        let v0 = 0x2::coin::from_balance<T0>(0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::get_token_to_vault<T0>(arg2, arg13), arg16);
        let v1 = cetus_swap_internal<T0, T1>(arg0, arg5, arg6, v0, arg7, arg8, arg16);
        let v2 = 0x2::object::id<0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet_config::CloudWalletTokenHolder>(arg4);
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<T2>()) {
            let v3 = 0x2::coin::value<T1>(&v1);
            assert!(v3 >= arg14, 30001);
            let v4 = BuyToAlphaEvent{
                order_id     : arg11,
                from_token   : 0x1::type_name::get<T0>(),
                from_amount  : arg13,
                to_token     : 0x1::type_name::get<T1>(),
                to_amount    : v3,
                account_id   : arg12,
                cloud_wallet : 0x2::object::id_to_address(&v2),
            };
            0x2::event::emit<BuyToAlphaEvent>(v4);
            0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet::deposit<T1>(arg3, arg4, 0x2::coin::into_balance<T1>(v1), arg11, arg12, get_checksum<T0>(arg13, arg15), arg16);
            0x1::option::destroy_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg9);
            0x1::option::destroy_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg10);
            0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::mark_order_id_used(arg1, arg11);
            return v3
        };
        let v5 = cetus_swap_internal<T1, T2>(arg0, arg5, arg6, v1, arg9, arg10, arg16);
        let v6 = 0x2::coin::value<T2>(&v5);
        assert!(v6 >= arg14, 30001);
        let v7 = BuyToAlphaEvent{
            order_id     : arg11,
            from_token   : 0x1::type_name::get<T0>(),
            from_amount  : arg13,
            to_token     : 0x1::type_name::get<T2>(),
            to_amount    : v6,
            account_id   : arg12,
            cloud_wallet : 0x2::object::id_to_address(&v2),
        };
        0x2::event::emit<BuyToAlphaEvent>(v7);
        0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet::deposit<T2>(arg3, arg4, 0x2::coin::into_balance<T2>(v5), arg11, arg12, get_checksum<T0>(arg13, arg15), arg16);
        0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::mark_order_id_used(arg1, arg11);
        v6
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

    public fun credit_coin<T0>(arg0: &0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::VaultConfig, arg1: &mut 0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::VaultTokenHolder, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg3: &mut 0x2::tx_context::TxContext) {
        0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::only_operator(arg0, arg3);
        0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::only_allow_version(arg0);
        0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::credit_coin<T0>(arg1, arg2, arg3);
    }

    public fun emergency_withdraw<T0>(arg0: &0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::VaultConfig, arg1: &mut 0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::VaultTokenHolder, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::only_admin(arg0, arg4);
        0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::only_allow_version(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::emergency_withdraw<T0>(arg1, arg2), arg4), arg3);
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

    public(friend) fun get_checksum<T0>(arg0: u64, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg0 as u256))));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256(((arg1 / 1000) as u256))));
        0x2::hash::keccak256(&v0)
    }

    public fun rebalance_out<T0>(arg0: &0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::VaultConfig, arg1: &mut 0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::VaultTokenHolder, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::only_operator(arg0, arg4);
        0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::only_allow_version(arg0);
        0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::check_rebalance_to(arg0, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::rebalance_out<T0>(arg1, arg3), arg4), arg2);
        let v0 = RebalanceToCex{
            operator   : 0x2::tx_context::sender(arg4),
            amount     : arg3,
            to_address : arg2,
            token      : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<RebalanceToCex>(v0);
    }

    public fun sell_to_self_from_alpha_multi_hop_bluefin<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::VaultConfig, arg2: &mut 0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::VaultTokenHolder, arg3: &mut 0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet_config::CloudWalletConfig, arg4: &mut 0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet_config::CloudWalletTokenHolder, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>, arg7: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>, arg8: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>, arg9: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>, arg10: u256, arg11: u256, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) : u64 {
        swap_check<T2>(arg0, arg1, arg14, 0, arg10, arg16);
        let v0 = 0x2::object::id<0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet_config::CloudWalletTokenHolder>(arg4);
        let v1 = 0x2::coin::from_balance<T0>(0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet::quick_withdraw<T0>(0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::borrow_withdraw_cap(arg2), arg3, arg4, arg0, arg11, arg12, arg15), arg16);
        let v2 = bluefin_swap_internal<T0, T1>(arg0, arg5, v1, arg6, arg7, arg16);
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<T2>()) {
            let v3 = 0x2::coin::value<T1>(&v2);
            assert!(v3 >= arg13, 30001);
            let v4 = SellToSelfFromAlpha{
                order_id     : arg10,
                from_token   : 0x1::type_name::get<T0>(),
                from_amount  : arg12,
                to_token     : 0x1::type_name::get<T1>(),
                to_amount    : v3,
                withdraw_id  : arg11,
                cloud_wallet : 0x2::object::id_to_address(&v0),
            };
            0x2::event::emit<SellToSelfFromAlpha>(v4);
            0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::deposit_token_from_vault<T1>(arg2, v2);
            0x1::option::destroy_none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg8);
            0x1::option::destroy_none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>>(arg9);
            0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::mark_order_id_used(arg1, arg10);
            return v3
        };
        let v5 = bluefin_swap_internal<T1, T2>(arg0, arg5, v2, arg8, arg9, arg16);
        let v6 = 0x2::coin::value<T2>(&v5);
        assert!(v6 >= arg13, 30001);
        let v7 = SellToSelfFromAlpha{
            order_id     : arg10,
            from_token   : 0x1::type_name::get<T0>(),
            from_amount  : arg12,
            to_token     : 0x1::type_name::get<T2>(),
            to_amount    : v6,
            withdraw_id  : arg11,
            cloud_wallet : 0x2::object::id_to_address(&v0),
        };
        0x2::event::emit<SellToSelfFromAlpha>(v7);
        0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::deposit_token_from_vault<T2>(arg2, v5);
        0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::mark_order_id_used(arg1, arg10);
        v6
    }

    public fun sell_to_self_from_alpha_multi_hop_cetus<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::VaultConfig, arg2: &mut 0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::VaultTokenHolder, arg3: &mut 0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet_config::CloudWalletConfig, arg4: &mut 0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet_config::CloudWalletTokenHolder, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg7: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>, arg8: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>, arg9: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>, arg10: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>, arg11: u256, arg12: u256, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) : u64 {
        swap_check<T2>(arg0, arg1, arg15, 0, arg11, arg17);
        let v0 = 0x2::object::id<0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet_config::CloudWalletTokenHolder>(arg4);
        let v1 = 0x2::coin::from_balance<T0>(0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet::quick_withdraw<T0>(0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::borrow_withdraw_cap(arg2), arg3, arg4, arg0, arg12, arg13, arg16), arg17);
        let v2 = cetus_swap_internal<T0, T1>(arg0, arg5, arg6, v1, arg7, arg8, arg17);
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<T2>()) {
            let v3 = 0x2::coin::value<T1>(&v2);
            assert!(v3 >= arg14, 30001);
            let v4 = SellToSelfFromAlpha{
                order_id     : arg11,
                from_token   : 0x1::type_name::get<T0>(),
                from_amount  : arg13,
                to_token     : 0x1::type_name::get<T1>(),
                to_amount    : v3,
                withdraw_id  : arg12,
                cloud_wallet : 0x2::object::id_to_address(&v0),
            };
            0x2::event::emit<SellToSelfFromAlpha>(v4);
            0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::deposit_token_from_vault<T1>(arg2, v2);
            0x1::option::destroy_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg9);
            0x1::option::destroy_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg10);
            0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::mark_order_id_used(arg1, arg11);
            return v3
        };
        let v5 = cetus_swap_internal<T1, T2>(arg0, arg5, arg6, v2, arg9, arg10, arg17);
        let v6 = 0x2::coin::value<T2>(&v5);
        assert!(v6 >= arg14, 30001);
        let v7 = SellToSelfFromAlpha{
            order_id     : arg11,
            from_token   : 0x1::type_name::get<T0>(),
            from_amount  : arg13,
            to_token     : 0x1::type_name::get<T2>(),
            to_amount    : v6,
            withdraw_id  : arg12,
            cloud_wallet : 0x2::object::id_to_address(&v0),
        };
        0x2::event::emit<SellToSelfFromAlpha>(v7);
        0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::deposit_token_from_vault<T2>(arg2, v5);
        0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::mark_order_id_used(arg1, arg11);
        v6
    }

    public(friend) fun swap_check<T0>(arg0: &0x2::clock::Clock, arg1: &0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::VaultConfig, arg2: u64, arg3: u64, arg4: u256, arg5: &0x2::tx_context::TxContext) {
        0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::only_trusted_bot(arg1, arg5);
        0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::when_not_paused(arg1);
        0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::when_not_expired(arg0, arg2);
        0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::check_trade_token<T0>(arg1, arg3);
        0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::only_allow_version(arg1);
        0xa825d76d568c9ed1ab5f917a81697d6cc7d5c2e25f586ae9027a71d907f9b30c::vault_config::when_order_id_not_used(arg1, arg4);
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

