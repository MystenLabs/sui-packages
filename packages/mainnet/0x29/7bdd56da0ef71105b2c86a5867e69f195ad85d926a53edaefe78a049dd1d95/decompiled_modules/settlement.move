module 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::settlement {
    struct FinalSettlementEvent has copy, drop {
        pool_id: 0x2::object::ID,
        base_balance: u64,
        quote_balance: u64,
    }

    struct ClaimAssetsEvent has copy, drop {
        pool_id: 0x2::object::ID,
        base_out: u64,
        quote_out: u64,
        base_capital_burned: u64,
        quote_capital_burned: u64,
    }

    public fun claim_assets<T0, T1>(arg0: &mut 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::PoolState<T0, T1>, arg1: 0x2::coin::Coin<0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::BasePoolLiquidityCoin<T0, T1>>, arg2: 0x2::coin::Coin<0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::QuotePoolLiquidityCoin<T0, T1>>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::assert_pool_version<T0, T1>(arg0);
        let (v0, v1) = 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::claim_assets<T0, T1>(arg0, arg1, arg2, arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = ClaimAssetsEvent{
            pool_id              : 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::pool_id<T0, T1>(arg0),
            base_out             : 0x2::coin::value<T0>(&v3),
            quote_out            : 0x2::coin::value<T1>(&v2),
            base_capital_burned  : 0x2::coin::value<0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::BasePoolLiquidityCoin<T0, T1>>(&arg1),
            quote_capital_burned : 0x2::coin::value<0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::QuotePoolLiquidityCoin<T0, T1>>(&arg2),
        };
        0x2::event::emit<ClaimAssetsEvent>(v4);
        (v3, v2)
    }

    public fun final_settlement<T0, T1>(arg0: &0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::PoolState<T0, T1>) {
        0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::assert_pool_version<T0, T1>(arg1);
        0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::ownable::assert_pool_admin_cap_matches<T0, T1>(arg0, 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::pool_id<T0, T1>(arg1));
        0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::final_settlement<T0, T1>(arg1);
        let v0 = FinalSettlementEvent{
            pool_id       : 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::pool_id<T0, T1>(arg1),
            base_balance  : 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::base_balance<T0, T1>(arg1),
            quote_balance : 0x297bdd56da0ef71105b2c86a5867e69f195ad85d926a53edaefe78a049dd1d95::pool::quote_balance<T0, T1>(arg1),
        };
        0x2::event::emit<FinalSettlementEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

