module 0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault {
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

    public fun buy_to_alpha<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::VaultConfig, arg2: &mut 0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::VaultTokenHolder, arg3: &0x53b73487591bc610ec201f10fcdfcc09c2aab2a74177112539afeb0706c78d1d::cloud_wallet_config::CloudWalletConfig, arg4: &mut 0x53b73487591bc610ec201f10fcdfcc09c2aab2a74177112539afeb0706c78d1d::cloud_wallet_config::CloudWalletTokenHolder, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg8: u256, arg9: u256, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        if (0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::coin_a_is_whitelist<T0, T1>(arg1)) {
            swap_check<T0>(arg0, arg1, arg12, arg10, arg13);
            let v0 = 0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::get_token_to_vault<T1>(arg2, arg11);
            let v1 = BuyToAlphaEvent{
                order_id     : arg8,
                from_token   : 0x1::type_name::get<T0>(),
                from_amount  : arg10,
                to_token     : 0x1::type_name::get<T1>(),
                to_amount    : 0x2::balance::value<T1>(&v0),
                account_id   : arg9,
                cloud_wallet : @0x53b73487591bc610ec201f10fcdfcc09c2aab2a74177112539afeb0706c78d1d,
            };
            0x2::event::emit<BuyToAlphaEvent>(v1);
            0x53b73487591bc610ec201f10fcdfcc09c2aab2a74177112539afeb0706c78d1d::cloud_wallet::deposit<T1>(arg3, arg4, v0, arg8, arg9, get_checksum<T0>(arg10, arg12), arg13);
        } else {
            swap_check<T1>(arg0, arg1, arg12, arg10, arg13);
            let v2 = 0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::get_token_to_vault<T0>(arg2, arg10);
            let v3 = BuyToAlphaEvent{
                order_id     : arg8,
                from_token   : 0x1::type_name::get<T1>(),
                from_amount  : arg10,
                to_token     : 0x1::type_name::get<T0>(),
                to_amount    : 0x2::balance::value<T0>(&v2),
                account_id   : arg9,
                cloud_wallet : @0x53b73487591bc610ec201f10fcdfcc09c2aab2a74177112539afeb0706c78d1d,
            };
            0x2::event::emit<BuyToAlphaEvent>(v3);
            0x53b73487591bc610ec201f10fcdfcc09c2aab2a74177112539afeb0706c78d1d::cloud_wallet::deposit<T0>(arg3, arg4, v2, arg8, arg9, get_checksum<T1>(arg10, arg12), arg13);
        };
    }

    public fun buy_to_alpha_multi_hop<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::VaultConfig, arg2: &mut 0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::VaultTokenHolder, arg3: &0x53b73487591bc610ec201f10fcdfcc09c2aab2a74177112539afeb0706c78d1d::cloud_wallet_config::CloudWalletConfig, arg4: &mut 0x53b73487591bc610ec201f10fcdfcc09c2aab2a74177112539afeb0706c78d1d::cloud_wallet_config::CloudWalletTokenHolder, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg7: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>, arg8: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>, arg9: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>, arg10: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>, arg11: u256, arg12: u256, arg13: u64, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) : u64 {
        swap_check<T0>(arg0, arg1, arg15, arg13, arg16);
        let v0 = 0x2::coin::from_balance<T0>(0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::get_token_to_vault<T0>(arg2, arg13), arg16);
        let v1 = swap_internal<T0, T1>(arg0, arg5, arg6, v0, arg7, arg8, arg16);
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
                cloud_wallet : @0x53b73487591bc610ec201f10fcdfcc09c2aab2a74177112539afeb0706c78d1d,
            };
            0x2::event::emit<BuyToAlphaEvent>(v3);
            0x53b73487591bc610ec201f10fcdfcc09c2aab2a74177112539afeb0706c78d1d::cloud_wallet::deposit<T1>(arg3, arg4, 0x2::coin::into_balance<T1>(v1), arg11, arg12, get_checksum<T0>(arg13, arg15), arg16);
            return v2
        };
        let v4 = swap_internal<T1, T2>(arg0, arg5, arg6, v1, arg9, arg10, arg16);
        let v5 = 0x2::coin::value<T2>(&v4);
        assert!(v5 >= arg14, 30001);
        let v6 = BuyToAlphaEvent{
            order_id     : arg11,
            from_token   : 0x1::type_name::get<T0>(),
            from_amount  : arg13,
            to_token     : 0x1::type_name::get<T2>(),
            to_amount    : v5,
            account_id   : arg12,
            cloud_wallet : @0x53b73487591bc610ec201f10fcdfcc09c2aab2a74177112539afeb0706c78d1d,
        };
        0x2::event::emit<BuyToAlphaEvent>(v6);
        0x53b73487591bc610ec201f10fcdfcc09c2aab2a74177112539afeb0706c78d1d::cloud_wallet::deposit<T2>(arg3, arg4, 0x2::coin::into_balance<T2>(v4), arg11, arg12, get_checksum<T1>(0x2::coin::value<T1>(&v1), arg15), arg16);
        v5
    }

    public fun credit_coin<T0>(arg0: &0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::VaultConfig, arg1: &mut 0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::VaultTokenHolder, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg3: &mut 0x2::tx_context::TxContext) {
        0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::only_operator(arg0, arg3);
        0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::only_allow_version(arg0);
        0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::credit_coin<T0>(arg1, arg2, arg3);
    }

    public fun emergency_withdraw<T0>(arg0: &0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::VaultConfig, arg1: &mut 0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::VaultTokenHolder, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::only_admin(arg0, arg4);
        0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::only_allow_version(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::emergency_withdraw<T0>(arg1, arg2), arg4), arg3);
    }

    public(friend) fun get_checksum<T0>(arg0: u64, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg0 as u256))));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg1 as u256))));
        0x2::hash::keccak256(&v0)
    }

    public fun rebalance_out<T0>(arg0: &0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::VaultConfig, arg1: &mut 0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::VaultTokenHolder, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::only_operator(arg0, arg4);
        0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::only_allow_version(arg0);
        0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::check_rebalance_to(arg0, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::rebalance_out<T0>(arg1, arg3), arg4), arg2);
        let v0 = RebalanceToCex{
            operator   : 0x2::tx_context::sender(arg4),
            amount     : arg3,
            to_address : arg2,
            token      : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<RebalanceToCex>(v0);
    }

    public fun sell_to_self_from_alpha<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::VaultConfig, arg2: &mut 0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::VaultTokenHolder, arg3: &mut 0x53b73487591bc610ec201f10fcdfcc09c2aab2a74177112539afeb0706c78d1d::cloud_wallet_config::CloudWalletConfig, arg4: &mut 0x53b73487591bc610ec201f10fcdfcc09c2aab2a74177112539afeb0706c78d1d::cloud_wallet_config::CloudWalletTokenHolder, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg8: u256, arg9: u256, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) : u64 {
        if (0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::coin_a_is_whitelist<T0, T1>(arg1)) {
            swap_check<T0>(arg0, arg1, arg12, 0, arg14);
            let v1 = 0x53b73487591bc610ec201f10fcdfcc09c2aab2a74177112539afeb0706c78d1d::cloud_wallet::quick_withdraw<T0>(0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::borrow_withdraw_cap(arg1), arg3, arg4, arg0, arg9, arg10, arg13);
            let v2 = 0x2::balance::value<T0>(&v1);
            let v3 = SellToSelfFromAlpha{
                order_id     : arg8,
                from_token   : 0x1::type_name::get<T1>(),
                from_amount  : arg10,
                to_token     : 0x1::type_name::get<T0>(),
                to_amount    : v2,
                withdraw_id  : arg9,
                cloud_wallet : @0x53b73487591bc610ec201f10fcdfcc09c2aab2a74177112539afeb0706c78d1d,
            };
            0x2::event::emit<SellToSelfFromAlpha>(v3);
            0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::deposit_token_from_vault<T0>(arg2, 0x2::coin::from_balance<T0>(v1, arg14));
            v2
        } else {
            swap_check<T1>(arg0, arg1, arg12, 0, arg14);
            let v4 = 0x53b73487591bc610ec201f10fcdfcc09c2aab2a74177112539afeb0706c78d1d::cloud_wallet::quick_withdraw<T1>(0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::borrow_withdraw_cap(arg1), arg3, arg4, arg0, arg9, arg10, arg13);
            let v5 = 0x2::balance::value<T1>(&v4);
            assert!(v5 >= arg11, 30001);
            let v6 = SellToSelfFromAlpha{
                order_id     : arg8,
                from_token   : 0x1::type_name::get<T0>(),
                from_amount  : arg10,
                to_token     : 0x1::type_name::get<T1>(),
                to_amount    : v5,
                withdraw_id  : arg9,
                cloud_wallet : @0x53b73487591bc610ec201f10fcdfcc09c2aab2a74177112539afeb0706c78d1d,
            };
            0x2::event::emit<SellToSelfFromAlpha>(v6);
            0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::deposit_token_from_vault<T1>(arg2, 0x2::coin::from_balance<T1>(v4, arg14));
            v5
        }
    }

    public fun sell_to_self_from_alpha_multi_hop<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::VaultConfig, arg2: &mut 0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::VaultTokenHolder, arg3: &mut 0x53b73487591bc610ec201f10fcdfcc09c2aab2a74177112539afeb0706c78d1d::cloud_wallet_config::CloudWalletConfig, arg4: &mut 0x53b73487591bc610ec201f10fcdfcc09c2aab2a74177112539afeb0706c78d1d::cloud_wallet_config::CloudWalletTokenHolder, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg7: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>, arg8: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>, arg9: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>, arg10: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>, arg11: u256, arg12: u256, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) : u64 {
        swap_check<T2>(arg0, arg1, arg15, 0, arg17);
        let v0 = 0x2::coin::from_balance<T0>(0x53b73487591bc610ec201f10fcdfcc09c2aab2a74177112539afeb0706c78d1d::cloud_wallet::quick_withdraw<T0>(0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::borrow_withdraw_cap(arg1), arg3, arg4, arg0, arg12, arg13, arg16), arg17);
        let v1 = swap_internal<T0, T1>(arg0, arg5, arg6, v0, arg7, arg8, arg17);
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
                cloud_wallet : @0x53b73487591bc610ec201f10fcdfcc09c2aab2a74177112539afeb0706c78d1d,
            };
            0x2::event::emit<SellToSelfFromAlpha>(v3);
            0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::deposit_token_from_vault<T1>(arg2, v1);
            return v2
        };
        let v4 = swap_internal<T1, T2>(arg0, arg5, arg6, v1, arg9, arg10, arg17);
        let v5 = 0x2::coin::value<T2>(&v4);
        assert!(v5 >= arg14, 30001);
        let v6 = SellToSelfFromAlpha{
            order_id     : arg11,
            from_token   : 0x1::type_name::get<T0>(),
            from_amount  : arg13,
            to_token     : 0x1::type_name::get<T2>(),
            to_amount    : v5,
            withdraw_id  : arg12,
            cloud_wallet : @0x53b73487591bc610ec201f10fcdfcc09c2aab2a74177112539afeb0706c78d1d,
        };
        0x2::event::emit<SellToSelfFromAlpha>(v6);
        0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::deposit_token_from_vault<T2>(arg2, v4);
        v5
    }

    public fun swap_check<T0>(arg0: &0x2::clock::Clock, arg1: &0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::VaultConfig, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::only_trusted_bot(arg1, arg4);
        0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::when_not_paused(arg1);
        0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::when_not_expired(arg0, arg2);
        0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::check_trade_token<T0>(arg1, arg3);
        0x6f7b8990fa5957f5038d6cbe5776b8b85c26554c49c4fe0149b3bd7e3c191993::vault_config::only_allow_version(arg1);
    }

    fun swap_internal<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>, arg5: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4)) {
            0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_a2b<T0, T1>(arg1, 0x1::option::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4), arg2, arg3, arg0, arg6)
        } else {
            assert!(0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg5), 30002);
            0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_b2a<T1, T0>(arg1, 0x1::option::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg5), arg2, arg3, arg0, arg6)
        }
    }

    // decompiled from Move bytecode v6
}

