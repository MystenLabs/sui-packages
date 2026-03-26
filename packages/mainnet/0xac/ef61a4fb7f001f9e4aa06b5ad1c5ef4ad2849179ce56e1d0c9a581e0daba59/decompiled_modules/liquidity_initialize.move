module 0xacef61a4fb7f001f9e4aa06b5ad1c5ef4ad2849179ce56e1d0c9a581e0daba59::liquidity_initialize {
    public(friend) fun create_outcome_markets<T0, T1>(arg0: &0x962f4be9d1940d6c57cc1da8bfff797a57be714456b6e5a742415e1f102053b6::coin_escrow::TokenEscrow<T0, T1>, arg1: u64, arg2: u64, arg3: 0x1::option::Option<u128>, arg4: u64, arg5: u64, arg6: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::market_state_mutation_auth::MarketStateMutationAuth, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : vector<0x962f4be9d1940d6c57cc1da8bfff797a57be714456b6e5a742415e1f102053b6::conditional_amm::LiquidityPool> {
        assert!(arg1 > 0, 105);
        assert!(arg1 <= 255, 105);
        assert!(0x962f4be9d1940d6c57cc1da8bfff797a57be714456b6e5a742415e1f102053b6::coin_escrow::caps_registered_count<T0, T1>(arg0) == arg1, 106);
        assert!(0x1::option::is_some<u128>(&arg3), 107);
        let v0 = 0x1::vector::empty<0x962f4be9d1940d6c57cc1da8bfff797a57be714456b6e5a742415e1f102053b6::conditional_amm::LiquidityPool>();
        let v1 = 0;
        while (v1 < arg1) {
            0x1::vector::push_back<0x962f4be9d1940d6c57cc1da8bfff797a57be714456b6e5a742415e1f102053b6::conditional_amm::LiquidityPool>(&mut v0, 0x962f4be9d1940d6c57cc1da8bfff797a57be714456b6e5a742415e1f102053b6::conditional_amm::new_empty_pool(0x962f4be9d1940d6c57cc1da8bfff797a57be714456b6e5a742415e1f102053b6::market_state::market_id(0x962f4be9d1940d6c57cc1da8bfff797a57be714456b6e5a742415e1f102053b6::coin_escrow::get_market_state<T0, T1>(arg0)), (v1 as u8), arg5, *0x1::option::borrow<u128>(&arg3), arg2, arg4, arg6, arg7, arg8));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

