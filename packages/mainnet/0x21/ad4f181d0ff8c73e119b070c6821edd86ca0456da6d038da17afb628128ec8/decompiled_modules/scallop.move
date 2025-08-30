module 0x21ad4f181d0ff8c73e119b070c6821edd86ca0456da6d038da17afb628128ec8::scallop {
    struct ScallopStrategy<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_access: 0x1::option::Option<0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::VaultAccess>,
        underlying_nominal_value: u64,
        collected_profit: 0x2::balance::Balance<T0>,
        market_coin: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>,
    }

    public fun new<T0>(arg0: &0xe8189be168b46b9ed1f3aaa669dbff2eccea14649baaffaea74c1c2a8fa3d641::token::PlatformCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopStrategy<T0>{
            id                       : 0x2::object::new(arg1),
            vault_access             : 0x1::option::none<0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::VaultAccess>(),
            underlying_nominal_value : 0,
            collected_profit         : 0x2::balance::zero<T0>(),
            market_coin              : 0x2::balance::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(),
        };
        0x2::transfer::share_object<ScallopStrategy<T0>>(v0);
    }

    public fun from_scoin(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock, arg4: u64) : u64 {
        let (v0, v1, v2, v3) = get_reserve_stats(arg0, arg1, arg2, arg3);
        0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(arg4, v0 + v1 - v2, v3)
    }

    public fun get_reserve_stats(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg0, arg1, arg3);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg1)), arg2))
    }

    public fun join_to_vault<T0, T1>(arg0: &mut ScallopStrategy<T0>, arg1: &0x21ad4f181d0ff8c73e119b070c6821edd86ca0456da6d038da17afb628128ec8::config::StrategyConfig, arg2: &0xe8189be168b46b9ed1f3aaa669dbff2eccea14649baaffaea74c1c2a8fa3d641::token::PlatformCap, arg3: &mut 0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::Vault<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0x21ad4f181d0ff8c73e119b070c6821edd86ca0456da6d038da17afb628128ec8::config::assert_version(arg1);
        0x1::option::fill<0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::VaultAccess>(&mut arg0.vault_access, 0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::add_strategy<T0, T1>(arg2, arg3, arg4));
    }

    public fun rebalance<T0, T1>(arg0: &mut ScallopStrategy<T0>, arg1: &0x21ad4f181d0ff8c73e119b070c6821edd86ca0456da6d038da17afb628128ec8::config::StrategyConfig, arg2: &0xe8189be168b46b9ed1f3aaa669dbff2eccea14649baaffaea74c1c2a8fa3d641::token::PlatformCap, arg3: &mut 0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::Vault<T0, T1>, arg4: &0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::RebalanceAmounts, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x21ad4f181d0ff8c73e119b070c6821edd86ca0456da6d038da17afb628128ec8::config::assert_version(arg1);
        let v0 = 0x1::option::borrow<0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::VaultAccess>(&arg0.vault_access);
        let (v1, v2) = 0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::rebalance_amounts_get(arg4, v0);
        if (v2 > 0) {
            let v3 = to_scoin(arg5, arg6, 0x1::type_name::get<T0>(), arg7, v2);
            let v4 = 0x2::coin::into_balance<T0>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg5, arg6, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg0.market_coin, v3), arg8), arg7, arg8));
            if (0x2::balance::value<T0>(&v4) > v2) {
                0x2::balance::join<T0>(&mut arg0.collected_profit, 0x2::balance::split<T0>(&mut v4, 0x2::balance::value<T0>(&v4) - v2));
            };
            0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::strategy_repay<T0, T1>(arg3, v0, v4);
            arg0.underlying_nominal_value = arg0.underlying_nominal_value - 0x2::balance::value<T0>(&v4);
        } else if (v1 > 0) {
            let v5 = 0x1::u64::min(v1, 0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::free_balance<T0, T1>(arg3));
            0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg0.market_coin, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg5, arg6, 0x2::coin::from_balance<T0>(0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::strategy_borrow<T0, T1>(arg3, v0, v5), arg8), arg7, arg8)));
            arg0.underlying_nominal_value = arg0.underlying_nominal_value + v5;
        };
    }

    public fun remove_from_vault<T0, T1>(arg0: &mut ScallopStrategy<T0>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x21ad4f181d0ff8c73e119b070c6821edd86ca0456da6d038da17afb628128ec8::config::StrategyConfig, arg4: &0xe8189be168b46b9ed1f3aaa669dbff2eccea14649baaffaea74c1c2a8fa3d641::token::PlatformCap, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::StrategyRemovalTicket<T0, T1> {
        0x21ad4f181d0ff8c73e119b070c6821edd86ca0456da6d038da17afb628128ec8::config::assert_version(arg3);
        0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::new_strategy_removal_ticket<T0, T1>(0x1::option::extract<0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::VaultAccess>(&mut arg0.vault_access), 0x2::coin::into_balance<T0>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg1, arg2, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::balance::withdraw_all<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg0.market_coin), arg6), arg5, arg6)))
    }

    public fun to_scoin(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock, arg4: u64) : u64 {
        let (v0, v1, v2, v3) = get_reserve_stats(arg0, arg1, arg2, arg3);
        let v4 = if (v3 > 0) {
            0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(arg4, v3, v0 + v1 - v2)
        } else {
            arg4
        };
        assert!(v4 > 0, 1);
        v4
    }

    public fun total_collateral<T0>(arg0: &ScallopStrategy<T0>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock) : u64 {
        from_scoin(arg1, arg2, 0x1::type_name::get<T0>(), arg3, 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg0.market_coin))
    }

    public fun withdraw<T0, T1>(arg0: &mut ScallopStrategy<T0>, arg1: &0x21ad4f181d0ff8c73e119b070c6821edd86ca0456da6d038da17afb628128ec8::config::StrategyConfig, arg2: &mut 0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::WithdrawTicket<T0, T1>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x21ad4f181d0ff8c73e119b070c6821edd86ca0456da6d038da17afb628128ec8::config::assert_version(arg1);
        let v0 = 0x1::option::borrow<0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::VaultAccess>(&arg0.vault_access);
        let v1 = 0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::withdraw_ticket_to_withdraw<T0, T1>(arg2, v0);
        if (v1 == 0) {
            return
        };
        let v2 = to_scoin(arg3, arg4, 0x1::type_name::get<T0>(), arg5, v1);
        let v3 = 0x2::coin::into_balance<T0>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg3, arg4, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg0.market_coin, v2), arg6), arg5, arg6));
        if (0x2::balance::value<T0>(&v3) > v1) {
            0x2::balance::join<T0>(&mut arg0.collected_profit, 0x2::balance::split<T0>(&mut v3, 0x2::balance::value<T0>(&v3) - v1));
        };
        0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::vault::strategy_withdraw_to_ticket<T0, T1>(arg2, v0, v3);
        arg0.underlying_nominal_value = arg0.underlying_nominal_value - v1;
    }

    // decompiled from Move bytecode v6
}

