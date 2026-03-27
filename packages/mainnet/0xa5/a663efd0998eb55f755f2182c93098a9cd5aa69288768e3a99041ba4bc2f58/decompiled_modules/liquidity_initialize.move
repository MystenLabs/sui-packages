module 0xa5a663efd0998eb55f755f2182c93098a9cd5aa69288768e3a99041ba4bc2f58::liquidity_initialize {
    public(friend) fun create_outcome_markets<T0, T1>(arg0: &0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::coin_escrow::TokenEscrow<T0, T1>, arg1: u64, arg2: u64, arg3: 0x1::option::Option<u128>, arg4: u64, arg5: u64, arg6: &0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::market_state_mutation_auth::MarketStateMutationAuth, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : vector<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool> {
        assert!(arg1 > 0, 105);
        assert!(arg1 <= 255, 105);
        assert!(0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::coin_escrow::caps_registered_count<T0, T1>(arg0) == arg1, 106);
        assert!(0x1::option::is_some<u128>(&arg3), 107);
        let v0 = 0x1::vector::empty<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>();
        let v1 = 0;
        while (v1 < arg1) {
            0x1::vector::push_back<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>(&mut v0, 0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::new_empty_pool(0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::market_state::market_id(0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::coin_escrow::get_market_state<T0, T1>(arg0)), (v1 as u8), arg5, *0x1::option::borrow<u128>(&arg3), arg2, arg4, arg6, arg7, arg8));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

