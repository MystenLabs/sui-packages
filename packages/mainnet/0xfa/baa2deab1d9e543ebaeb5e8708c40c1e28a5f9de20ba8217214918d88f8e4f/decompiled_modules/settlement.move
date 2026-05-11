module 0xfabaa2deab1d9e543ebaeb5e8708c40c1e28a5f9de20ba8217214918d88f8e4f::settlement {
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

    public fun claim_assets<T0, T1>(arg0: &mut 0xfabaa2deab1d9e543ebaeb5e8708c40c1e28a5f9de20ba8217214918d88f8e4f::pool::PoolState<T0, T1>, arg1: 0x2::coin::Coin<0xfabaa2deab1d9e543ebaeb5e8708c40c1e28a5f9de20ba8217214918d88f8e4f::pool::BasePoolLiquidityCoin<T0, T1>>, arg2: 0x2::coin::Coin<0xfabaa2deab1d9e543ebaeb5e8708c40c1e28a5f9de20ba8217214918d88f8e4f::pool::QuotePoolLiquidityCoin<T0, T1>>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xfabaa2deab1d9e543ebaeb5e8708c40c1e28a5f9de20ba8217214918d88f8e4f::pool::assert_pool_version<T0, T1>(arg0);
        let (v0, v1) = 0xfabaa2deab1d9e543ebaeb5e8708c40c1e28a5f9de20ba8217214918d88f8e4f::pool::claim_assets<T0, T1>(arg0, arg1, arg2, arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = ClaimAssetsEvent{
            pool_id              : 0xfabaa2deab1d9e543ebaeb5e8708c40c1e28a5f9de20ba8217214918d88f8e4f::pool::pool_id<T0, T1>(arg0),
            base_out             : 0x2::coin::value<T0>(&v3),
            quote_out            : 0x2::coin::value<T1>(&v2),
            base_capital_burned  : 0x2::coin::value<0xfabaa2deab1d9e543ebaeb5e8708c40c1e28a5f9de20ba8217214918d88f8e4f::pool::BasePoolLiquidityCoin<T0, T1>>(&arg1),
            quote_capital_burned : 0x2::coin::value<0xfabaa2deab1d9e543ebaeb5e8708c40c1e28a5f9de20ba8217214918d88f8e4f::pool::QuotePoolLiquidityCoin<T0, T1>>(&arg2),
        };
        0x2::event::emit<ClaimAssetsEvent>(v4);
        (v3, v2)
    }

    public fun final_settlement<T0, T1>(arg0: &0xfabaa2deab1d9e543ebaeb5e8708c40c1e28a5f9de20ba8217214918d88f8e4f::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0xfabaa2deab1d9e543ebaeb5e8708c40c1e28a5f9de20ba8217214918d88f8e4f::pool::PoolState<T0, T1>) {
        0xfabaa2deab1d9e543ebaeb5e8708c40c1e28a5f9de20ba8217214918d88f8e4f::pool::assert_pool_version<T0, T1>(arg1);
        0xfabaa2deab1d9e543ebaeb5e8708c40c1e28a5f9de20ba8217214918d88f8e4f::ownable::assert_pool_admin_cap_matches<T0, T1>(arg0, 0xfabaa2deab1d9e543ebaeb5e8708c40c1e28a5f9de20ba8217214918d88f8e4f::pool::pool_id<T0, T1>(arg1));
        0xfabaa2deab1d9e543ebaeb5e8708c40c1e28a5f9de20ba8217214918d88f8e4f::pool::final_settlement<T0, T1>(arg1);
        let v0 = FinalSettlementEvent{
            pool_id       : 0xfabaa2deab1d9e543ebaeb5e8708c40c1e28a5f9de20ba8217214918d88f8e4f::pool::pool_id<T0, T1>(arg1),
            base_balance  : 0xfabaa2deab1d9e543ebaeb5e8708c40c1e28a5f9de20ba8217214918d88f8e4f::pool::base_balance<T0, T1>(arg1),
            quote_balance : 0xfabaa2deab1d9e543ebaeb5e8708c40c1e28a5f9de20ba8217214918d88f8e4f::pool::quote_balance<T0, T1>(arg1),
        };
        0x2::event::emit<FinalSettlementEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

