module 0x21ad4f181d0ff8c73e119b070c6821edd86ca0456da6d038da17afb628128ec8::navi {
    struct NaviStrategy<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_access: 0x1::option::Option<0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::VaultAccess>,
        underlying_nominal_value: u64,
        collected_profit: 0x2::balance::Balance<T0>,
        account: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
    }

    public fun new<T0>(arg0: &0xe8189be168b46b9ed1f3aaa669dbff2eccea14649baaffaea74c1c2a8fa3d641::token::PlatformCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviStrategy<T0>{
            id                       : 0x2::object::new(arg1),
            vault_access             : 0x1::option::none<0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::VaultAccess>(),
            underlying_nominal_value : 0,
            collected_profit         : 0x2::balance::zero<T0>(),
            account                  : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg1),
        };
        0x2::transfer::share_object<NaviStrategy<T0>>(v0);
    }

    public fun join_to_vault<T0, T1>(arg0: &mut NaviStrategy<T0>, arg1: &0x21ad4f181d0ff8c73e119b070c6821edd86ca0456da6d038da17afb628128ec8::config::StrategyConfig, arg2: &0xe8189be168b46b9ed1f3aaa669dbff2eccea14649baaffaea74c1c2a8fa3d641::token::PlatformCap, arg3: &mut 0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::Vault<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0x21ad4f181d0ff8c73e119b070c6821edd86ca0456da6d038da17afb628128ec8::config::assert_version(arg1);
        0x1::option::fill<0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::VaultAccess>(&mut arg0.vault_access, 0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::add_strategy<T0, T1>(arg2, arg3, arg4));
    }

    public fun rebalance<T0, T1>(arg0: &mut NaviStrategy<T0>, arg1: &0x21ad4f181d0ff8c73e119b070c6821edd86ca0456da6d038da17afb628128ec8::config::StrategyConfig, arg2: &0xe8189be168b46b9ed1f3aaa669dbff2eccea14649baaffaea74c1c2a8fa3d641::token::PlatformCap, arg3: &mut 0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::Vault<T0, T1>, arg4: &0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::RebalanceAmounts, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0x21ad4f181d0ff8c73e119b070c6821edd86ca0456da6d038da17afb628128ec8::config::assert_version(arg1);
        let v0 = 0x1::option::borrow<0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::VaultAccess>(&arg0.vault_access);
        let (v1, v2) = 0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::rebalance_amounts_get(arg4, v0);
        if (v2 > 0) {
            let v3 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg11, arg5, arg6, arg7, arg8, v2, arg9, arg10, &arg0.account);
            if (0x2::balance::value<T0>(&v3) > v2) {
                0x2::balance::join<T0>(&mut arg0.collected_profit, 0x2::balance::split<T0>(&mut v3, 0x2::balance::value<T0>(&v3) - v2));
            };
            0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::strategy_repay<T0, T1>(arg3, v0, v3);
            arg0.underlying_nominal_value = arg0.underlying_nominal_value - 0x2::balance::value<T0>(&v3);
        } else {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg11, arg6, arg7, arg8, 0x2::coin::from_balance<T0>(0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::strategy_borrow<T0, T1>(arg3, v0, 0x1::u64::min(v1, 0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::free_balance<T0, T1>(arg3))), arg12), arg9, arg10, &arg0.account);
        };
    }

    public fun remove_from_vault<T0, T1>(arg0: &mut NaviStrategy<T0>, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x21ad4f181d0ff8c73e119b070c6821edd86ca0456da6d038da17afb628128ec8::config::StrategyConfig, arg8: &0xe8189be168b46b9ed1f3aaa669dbff2eccea14649baaffaea74c1c2a8fa3d641::token::PlatformCap, arg9: &0x2::clock::Clock) : 0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::StrategyRemovalTicket<T0, T1> {
        0x21ad4f181d0ff8c73e119b070c6821edd86ca0456da6d038da17afb628128ec8::config::assert_version(arg7);
        let v0 = total_collateral<T0>(arg0, arg2, arg4);
        0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::new_strategy_removal_ticket<T0, T1>(0x1::option::extract<0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::VaultAccess>(&mut arg0.vault_access), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg9, arg1, arg2, arg3, arg4, v0, arg5, arg6, &arg0.account))
    }

    public fun total_collateral<T0>(arg0: &NaviStrategy<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: u8) : u64 {
        let v0 = 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg0.account);
        (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg1, arg2, 0x2::object::id_to_address(&v0)) as u64)
    }

    public fun withdraw<T0, T1>(arg0: &mut NaviStrategy<T0>, arg1: &0x21ad4f181d0ff8c73e119b070c6821edd86ca0456da6d038da17afb628128ec8::config::StrategyConfig, arg2: &mut 0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::WithdrawTicket<T0, T1>, arg3: &0xe8189be168b46b9ed1f3aaa669dbff2eccea14649baaffaea74c1c2a8fa3d641::token::PlatformCap, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg10: &0x2::clock::Clock) {
        0x21ad4f181d0ff8c73e119b070c6821edd86ca0456da6d038da17afb628128ec8::config::assert_version(arg1);
        let v0 = 0x1::option::borrow<0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::VaultAccess>(&arg0.vault_access);
        let v1 = 0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::withdraw_ticket_to_withdraw<T0, T1>(arg2, v0);
        if (v1 == 0) {
            return
        };
        let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg10, arg4, arg5, arg6, arg7, v1, arg8, arg9, &arg0.account);
        if (0x2::balance::value<T0>(&v2) > v1) {
            0x2::balance::join<T0>(&mut arg0.collected_profit, 0x2::balance::split<T0>(&mut v2, 0x2::balance::value<T0>(&v2) - v1));
        };
        0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::strategy_withdraw_to_ticket<T0, T1>(arg2, v0, v2);
        arg0.underlying_nominal_value = arg0.underlying_nominal_value - v1;
    }

    // decompiled from Move bytecode v6
}

