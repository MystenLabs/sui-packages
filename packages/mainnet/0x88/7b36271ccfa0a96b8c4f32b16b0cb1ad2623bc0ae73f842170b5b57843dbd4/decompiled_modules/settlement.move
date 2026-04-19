module 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::settlement {
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

    public fun claim_assets<T0, T1>(arg0: &mut 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::PoolState<T0, T1>, arg1: 0x2::coin::Coin<0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::BasePoolLiquidityCoin<T0, T1>>, arg2: 0x2::coin::Coin<0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::QuotePoolLiquidityCoin<T0, T1>>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::assert_pool_version<T0, T1>(arg0);
        let (v0, v1) = 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::claim_assets<T0, T1>(arg0, arg1, arg2, arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = ClaimAssetsEvent{
            pool_id              : 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::pool_id<T0, T1>(arg0),
            base_out             : 0x2::coin::value<T0>(&v3),
            quote_out            : 0x2::coin::value<T1>(&v2),
            base_capital_burned  : 0x2::coin::value<0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::BasePoolLiquidityCoin<T0, T1>>(&arg1),
            quote_capital_burned : 0x2::coin::value<0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::QuotePoolLiquidityCoin<T0, T1>>(&arg2),
        };
        0x2::event::emit<ClaimAssetsEvent>(v4);
        (v3, v2)
    }

    public fun final_settlement<T0, T1>(arg0: &0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::ownable::PoolAdminCap<T0, T1>, arg1: &mut 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::PoolState<T0, T1>) {
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::assert_pool_version<T0, T1>(arg1);
        0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::final_settlement<T0, T1>(arg1);
        let v0 = FinalSettlementEvent{
            pool_id       : 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::pool_id<T0, T1>(arg1),
            base_balance  : 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::base_balance<T0, T1>(arg1),
            quote_balance : 0x887b36271ccfa0a96b8c4f32b16b0cb1ad2623bc0ae73f842170b5b57843dbd4::pool::quote_balance<T0, T1>(arg1),
        };
        0x2::event::emit<FinalSettlementEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

