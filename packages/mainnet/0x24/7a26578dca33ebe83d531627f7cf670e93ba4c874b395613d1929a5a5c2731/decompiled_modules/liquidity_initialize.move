module 0x247a26578dca33ebe83d531627f7cf670e93ba4c874b395613d1929a5a5c2731::liquidity_initialize {
    public(friend) fun create_outcome_markets<T0, T1>(arg0: &0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::TokenEscrow<T0, T1>, arg1: u64, arg2: u64, arg3: 0x1::option::Option<u128>, arg4: u64, arg5: u64, arg6: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::market_state_mutation_auth::MarketStateMutationAuth, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : vector<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_amm::LiquidityPool> {
        assert!(arg1 > 0, 105);
        assert!(arg1 <= 255, 105);
        assert!(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::caps_registered_count<T0, T1>(arg0) == arg1, 106);
        assert!(0x1::option::is_some<u128>(&arg3), 107);
        let v0 = 0x1::vector::empty<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_amm::LiquidityPool>();
        let v1 = 0;
        while (v1 < arg1) {
            0x1::vector::push_back<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_amm::LiquidityPool>(&mut v0, 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_amm::new_empty_pool(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::market_id(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::get_market_state<T0, T1>(arg0)), (v1 as u8), arg5, *0x1::option::borrow<u128>(&arg3), arg2, arg4, arg6, arg7, arg8));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

