module 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::liquidity_provider {
    struct DepositEvent has copy, drop {
        pool_id: 0x2::object::ID,
        is_base: bool,
        amount: u64,
        capital_minted: u64,
        pool_base_balance: u64,
        pool_quote_balance: u64,
    }

    struct WithdrawEvent has copy, drop {
        pool_id: 0x2::object::ID,
        is_base: bool,
        amount: u64,
        capital_burned: u64,
        pool_base_balance: u64,
        pool_quote_balance: u64,
    }

    public fun deposit_base<T0, T1>(arg0: &0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::ownable::LiquidityOperatorCap<T0, T1>, arg1: &mut 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::PoolState<T0, T1>, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::BasePoolLiquidityCoin<T0, T1>> {
        0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::assert_pool_version<T0, T1>(arg1);
        0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::ownable::assert_liquidity_operator_cap_matches<T0, T1>(arg0, 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::pool_id<T0, T1>(arg1));
        0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::assert_deposit_base_allowed<T0, T1>(arg1);
        assert!(0x2::coin::value<T0>(arg2) >= arg3, 1);
        let v0 = 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::get_base_capital_coin_supply<T0, T1>(arg1);
        let v1 = 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::base_balance<T0, T1>(arg1);
        let v2 = if (v0 == 0) {
            arg3
        } else {
            assert!(v1 > 0, 2);
            0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::safe_math::safe_mul_div_u64(arg3, v0, v1)
        };
        let v3 = DepositEvent{
            pool_id            : 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::pool_id<T0, T1>(arg1),
            is_base            : true,
            amount             : arg3,
            capital_minted     : v2,
            pool_base_balance  : 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::base_balance<T0, T1>(arg1),
            pool_quote_balance : 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::quote_balance<T0, T1>(arg1),
        };
        0x2::event::emit<DepositEvent>(v3);
        0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::mint_base_capital<T0, T1>(arg1, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg2), arg3), v2, arg4)
    }

    public fun deposit_quote<T0, T1>(arg0: &0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::ownable::LiquidityOperatorCap<T0, T1>, arg1: &mut 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::PoolState<T0, T1>, arg2: &mut 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::QuotePoolLiquidityCoin<T0, T1>> {
        0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::assert_pool_version<T0, T1>(arg1);
        0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::ownable::assert_liquidity_operator_cap_matches<T0, T1>(arg0, 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::pool_id<T0, T1>(arg1));
        0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::assert_deposit_quote_allowed<T0, T1>(arg1);
        assert!(0x2::coin::value<T1>(arg2) >= arg3, 1);
        let v0 = 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::get_quote_capital_coin_supply<T0, T1>(arg1);
        let v1 = 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::quote_balance<T0, T1>(arg1);
        let v2 = if (v0 == 0) {
            arg3
        } else {
            assert!(v1 > 0, 2);
            0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::safe_math::safe_mul_div_u64(arg3, v0, v1)
        };
        let v3 = DepositEvent{
            pool_id            : 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::pool_id<T0, T1>(arg1),
            is_base            : false,
            amount             : arg3,
            capital_minted     : v2,
            pool_base_balance  : 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::base_balance<T0, T1>(arg1),
            pool_quote_balance : 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::quote_balance<T0, T1>(arg1),
        };
        0x2::event::emit<DepositEvent>(v3);
        0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::mint_quote_capital<T0, T1>(arg1, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg2), arg3), v2, arg4)
    }

    public fun withdraw_base<T0, T1>(arg0: &0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::ownable::LiquidityOperatorCap<T0, T1>, arg1: &mut 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::PoolState<T0, T1>, arg2: &mut 0x2::coin::Coin<0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::BasePoolLiquidityCoin<T0, T1>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::assert_pool_version<T0, T1>(arg1);
        0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::ownable::assert_liquidity_operator_cap_matches<T0, T1>(arg0, 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::pool_id<T0, T1>(arg1));
        0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::assert_withdraw_allowed<T0, T1>(arg1);
        let v0 = 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::safe_math::safe_mul_div_ceil_u64(arg3, 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::get_base_capital_coin_supply<T0, T1>(arg1), 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::base_balance<T0, T1>(arg1));
        assert!(0x2::coin::value<0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::BasePoolLiquidityCoin<T0, T1>>(arg2) >= v0, 1);
        0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::burn_base_capital_coin<T0, T1>(arg1, 0x2::balance::split<0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::BasePoolLiquidityCoin<T0, T1>>(0x2::coin::balance_mut<0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::BasePoolLiquidityCoin<T0, T1>>(arg2), v0));
        let v1 = WithdrawEvent{
            pool_id            : 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::pool_id<T0, T1>(arg1),
            is_base            : true,
            amount             : arg3,
            capital_burned     : v0,
            pool_base_balance  : 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::base_balance<T0, T1>(arg1),
            pool_quote_balance : 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::quote_balance<T0, T1>(arg1),
        };
        0x2::event::emit<WithdrawEvent>(v1);
        0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::base_coin_pay_out<T0, T1>(arg1, arg3, arg4)
    }

    public fun withdraw_quote<T0, T1>(arg0: &0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::ownable::LiquidityOperatorCap<T0, T1>, arg1: &mut 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::PoolState<T0, T1>, arg2: &mut 0x2::coin::Coin<0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::QuotePoolLiquidityCoin<T0, T1>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::assert_pool_version<T0, T1>(arg1);
        0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::ownable::assert_liquidity_operator_cap_matches<T0, T1>(arg0, 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::pool_id<T0, T1>(arg1));
        0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::assert_withdraw_allowed<T0, T1>(arg1);
        let v0 = 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::safe_math::safe_mul_div_ceil_u64(arg3, 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::get_quote_capital_coin_supply<T0, T1>(arg1), 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::quote_balance<T0, T1>(arg1));
        assert!(0x2::coin::value<0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::QuotePoolLiquidityCoin<T0, T1>>(arg2) >= v0, 1);
        0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::burn_quote_capital_coin<T0, T1>(arg1, 0x2::balance::split<0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::QuotePoolLiquidityCoin<T0, T1>>(0x2::coin::balance_mut<0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::QuotePoolLiquidityCoin<T0, T1>>(arg2), v0));
        let v1 = WithdrawEvent{
            pool_id            : 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::pool_id<T0, T1>(arg1),
            is_base            : false,
            amount             : arg3,
            capital_burned     : v0,
            pool_base_balance  : 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::base_balance<T0, T1>(arg1),
            pool_quote_balance : 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::quote_balance<T0, T1>(arg1),
        };
        0x2::event::emit<WithdrawEvent>(v1);
        0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::quote_coin_pay_out<T0, T1>(arg1, arg3, arg4)
    }

    // decompiled from Move bytecode v7
}

