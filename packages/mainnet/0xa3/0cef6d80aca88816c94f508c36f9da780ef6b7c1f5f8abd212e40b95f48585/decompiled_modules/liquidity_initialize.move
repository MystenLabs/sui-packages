module 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::liquidity_initialize {
    public(friend) fun create_outcome_markets<T0, T1>(arg0: &0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::TokenEscrow<T0, T1>, arg1: u64, arg2: u64, arg3: 0x1::option::Option<u128>, arg4: u64, arg5: u64, arg6: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::market_state_mutation_auth::MarketStateMutationAuth, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : vector<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool> {
        assert!(arg1 > 0, 105);
        assert!(arg1 <= 255, 105);
        assert!(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::caps_registered_count<T0, T1>(arg0) == arg1, 106);
        assert!(0x1::option::is_some<u128>(&arg3), 107);
        let v0 = 0x1::vector::empty<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>();
        let v1 = 0;
        while (v1 < arg1) {
            0x1::vector::push_back<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>(&mut v0, 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::new_empty_pool(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::market_state::market_id(0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::coin_escrow::get_market_state<T0, T1>(arg0)), (v1 as u8), arg5, *0x1::option::borrow<u128>(&arg3), arg2, arg4, arg6, arg7, arg8));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

