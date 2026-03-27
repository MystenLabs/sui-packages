module 0x76b28158f935a53b19dd7a71e8b6d8c5b90be1135d8ebbdba7be6b1a98e8a826::liquidity_initialize {
    public(friend) fun create_outcome_markets<T0, T1>(arg0: &0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::TokenEscrow<T0, T1>, arg1: u64, arg2: u64, arg3: 0x1::option::Option<u128>, arg4: u64, arg5: u64, arg6: &0x664a0e25093ade2eb071799f7b24a821a5eeb6f355986f6bc15c582b60d0c6a0::market_state_mutation_auth::MarketStateMutationAuth, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : vector<0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::conditional_amm::LiquidityPool> {
        assert!(arg1 > 0, 105);
        assert!(arg1 <= 255, 105);
        assert!(0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::caps_registered_count<T0, T1>(arg0) == arg1, 106);
        assert!(0x1::option::is_some<u128>(&arg3), 107);
        let v0 = 0x1::vector::empty<0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::conditional_amm::LiquidityPool>();
        let v1 = 0;
        while (v1 < arg1) {
            0x1::vector::push_back<0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::conditional_amm::LiquidityPool>(&mut v0, 0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::conditional_amm::new_empty_pool(0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::market_state::market_id(0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::get_market_state<T0, T1>(arg0)), (v1 as u8), arg5, *0x1::option::borrow<u128>(&arg3), arg2, arg4, arg6, arg7, arg8));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

