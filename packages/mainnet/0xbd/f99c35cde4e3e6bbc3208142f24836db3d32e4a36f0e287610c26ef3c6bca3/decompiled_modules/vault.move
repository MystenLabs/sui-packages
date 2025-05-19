module 0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault {
    struct RebalanceToCex has copy, drop {
        operator: address,
        amount: u64,
        to_address: address,
        token: 0x1::type_name::TypeName,
    }

    public fun buy_to_alpha<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::VaultConfig, arg2: &mut 0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::VaultTokenHolder, arg3: &0xa4654d465ccfad2f1dee3231f4b6797fc22a5489299186417bfbc589dc2b3241::cloud_wallet_config::CloudWalletConfig, arg4: &mut 0xa4654d465ccfad2f1dee3231f4b6797fc22a5489299186417bfbc589dc2b3241::cloud_wallet_config::CloudWalletTokenHolder, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg8: u256, arg9: u256, arg10: u64, arg11: u64, arg12: u64, arg13: vector<u8>, arg14: &mut 0x2::tx_context::TxContext) {
        if (0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::is_swap_a2b<T0, T1>(arg1)) {
            swap_check<T0>(arg0, arg1, arg12, arg10, arg14);
            let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_a2b<T0, T1>(arg5, arg6, arg7, 0x2::coin::from_balance<T0>(0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::get_token_to_vault<T0>(arg2, arg10), arg14), arg0, arg14);
            assert!(0x2::coin::value<T1>(&v0) >= arg11, 30002);
            0xa4654d465ccfad2f1dee3231f4b6797fc22a5489299186417bfbc589dc2b3241::cloud_wallet::deposit<T1>(arg3, arg4, 0x2::coin::into_balance<T1>(v0), arg8, arg9, arg13, arg14);
        } else {
            swap_check<T1>(arg0, arg1, arg12, arg10, arg14);
            let v1 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_b2a<T0, T1>(arg5, arg6, arg7, 0x2::coin::from_balance<T1>(0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::get_token_to_vault<T1>(arg2, arg10), arg14), arg0, arg14);
            assert!(0x2::coin::value<T0>(&v1) >= arg11, 30002);
            0xa4654d465ccfad2f1dee3231f4b6797fc22a5489299186417bfbc589dc2b3241::cloud_wallet::deposit<T0>(arg3, arg4, 0x2::coin::into_balance<T0>(v1), arg8, arg9, arg13, arg14);
        };
    }

    public fun buy_to_alpha_multi_hop<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::VaultConfig, arg2: &mut 0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::VaultTokenHolder, arg3: &mut 0xa4654d465ccfad2f1dee3231f4b6797fc22a5489299186417bfbc589dc2b3241::cloud_wallet_config::CloudWalletTokenHolder, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg8: u256, arg9: u256, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
    }

    public fun credit_coin<T0>(arg0: &0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::VaultConfig, arg1: &mut 0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::VaultTokenHolder, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg3: &mut 0x2::tx_context::TxContext) {
        0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::only_operator(arg0, arg3);
        0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::only_allow_version(arg0);
        0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::credit_coin<T0>(arg1, arg2, arg3);
    }

    public fun emergency_withdraw<T0>(arg0: &0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::VaultConfig, arg1: &mut 0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::VaultTokenHolder, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::only_admin(arg0, arg4);
        0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::only_allow_version(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::emergency_withdraw<T0>(arg0, arg1, arg2, arg4), arg4), arg3);
    }

    public fun rebalance_out<T0>(arg0: &0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::VaultConfig, arg1: &mut 0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::VaultTokenHolder, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::only_operator(arg0, arg4);
        0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::only_allow_version(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::rebalance_out<T0>(arg0, arg1, arg2, arg3), arg4), arg2);
        let v0 = RebalanceToCex{
            operator   : 0x2::tx_context::sender(arg4),
            amount     : arg3,
            to_address : arg2,
            token      : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<RebalanceToCex>(v0);
    }

    public fun sell_to_self_from_alpha<T0: drop>(arg0: &0x2::clock::Clock, arg1: &0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::VaultConfig, arg2: u256, arg3: u256, arg4: T0, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        swap_check<T0>(arg0, arg1, arg7, arg5, arg9);
    }

    public fun swap_check<T0>(arg0: &0x2::clock::Clock, arg1: &0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::VaultConfig, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::only_trusted_bot(arg1, arg4);
        0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::when_not_paused(arg1);
        0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::when_not_expired(arg0, arg2);
        0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::check_trade_token<T0>(arg1, arg3);
        0xbdf99c35cde4e3e6bbc3208142f24836db3d32e4a36f0e287610c26ef3c6bca3::vault_config::only_allow_version(arg1);
    }

    // decompiled from Move bytecode v6
}

