module 0x4a9f88cdee9f9e46df62e5e9bc63ff86806d50d3480c187d3b3c86b750711eaf::liquidity_initialize {
    public(friend) fun create_outcome_markets<T0, T1>(arg0: &0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::TokenEscrow<T0, T1>, arg1: u64, arg2: u64, arg3: 0x1::option::Option<u128>, arg4: u64, arg5: u64, arg6: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::market_state_mutation_auth::MarketStateMutationAuth, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : vector<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::LiquidityPool> {
        assert!(arg1 > 0, 105);
        assert!(arg1 <= 255, 105);
        assert!(0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::caps_registered_count<T0, T1>(arg0) == arg1, 106);
        assert!(0x1::option::is_some<u128>(&arg3), 107);
        let v0 = 0x1::vector::empty<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::LiquidityPool>();
        let v1 = 0;
        while (v1 < arg1) {
            0x1::vector::push_back<0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::LiquidityPool>(&mut v0, 0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm::new_empty_pool(0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::market_state::market_id(0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::coin_escrow::get_market_state<T0, T1>(arg0)), (v1 as u8), arg5, *0x1::option::borrow<u128>(&arg3), arg2, arg4, arg6, arg7, arg8));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

