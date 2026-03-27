module 0x5c8ef7a7e832456dd9a932a2ddb1cb9e8da84e8dfd918c925451efb87a46cd4f::liquidity_initialize {
    public(friend) fun create_outcome_markets<T0, T1>(arg0: &0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::TokenEscrow<T0, T1>, arg1: u64, arg2: u64, arg3: 0x1::option::Option<u128>, arg4: u64, arg5: u64, arg6: &0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::market_state_mutation_auth::MarketStateMutationAuth, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : vector<0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::conditional_amm::LiquidityPool> {
        assert!(arg1 > 0, 105);
        assert!(arg1 <= 255, 105);
        assert!(0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::caps_registered_count<T0, T1>(arg0) == arg1, 106);
        assert!(0x1::option::is_some<u128>(&arg3), 107);
        let v0 = 0x1::vector::empty<0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::conditional_amm::LiquidityPool>();
        let v1 = 0;
        while (v1 < arg1) {
            0x1::vector::push_back<0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::conditional_amm::LiquidityPool>(&mut v0, 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::conditional_amm::new_empty_pool(0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::market_state::market_id(0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::coin_escrow::get_market_state<T0, T1>(arg0)), (v1 as u8), arg5, *0x1::option::borrow<u128>(&arg3), arg2, arg4, arg6, arg7, arg8));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

