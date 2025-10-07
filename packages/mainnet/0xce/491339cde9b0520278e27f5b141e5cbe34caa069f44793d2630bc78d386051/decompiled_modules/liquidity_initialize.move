module 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::liquidity_initialize {
    fun assert_initial_reserves_consistency<T0, T1>(arg0: &0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::coin_escrow::TokenEscrow<T0, T1>, arg1: &vector<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::amm::LiquidityPool>) {
        let v0 = 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::outcome_count(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::coin_escrow::get_market_state<T0, T1>(arg0));
        assert!(0x1::vector::length<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::amm::LiquidityPool>(arg1) == v0, 102);
        let (v1, v2) = 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::coin_escrow::get_balances<T0, T1>(arg0);
        let v3 = 0;
        while (v3 < v0) {
            let v4 = 0x1::vector::borrow<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::amm::LiquidityPool>(arg1, v3);
            assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::amm::get_outcome_idx(v4) == (v3 as u8), 103);
            let (v5, v6) = 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::amm::get_reserves(v4);
            let v7 = 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::amm::get_protocol_fees(v4);
            assert!(v7 == 0, 101);
            let (_, _, v10, v11) = 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::coin_escrow::get_escrow_balances_and_supply<T0, T1>(arg0, v3);
            assert!(v5 + v10 == v1, 100);
            assert!(v6 + v7 + v11 == v2, 101);
            v3 = v3 + 1;
        };
    }

    public(friend) fun create_outcome_markets<T0, T1>(arg0: &mut 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::coin_escrow::TokenEscrow<T0, T1>, arg1: u64, arg2: vector<u64>, arg3: vector<u64>, arg4: u64, arg5: u128, arg6: u64, arg7: 0x2::balance::Balance<T0>, arg8: 0x2::balance::Balance<T1>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (vector<0x2::object::ID>, vector<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::amm::LiquidityPool>) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::empty<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::amm::LiquidityPool>();
        let v2 = 0;
        while (v2 < arg1) {
            let v3 = 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::coin_escrow::get_market_state<T0, T1>(arg0);
            let v4 = 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::new_supply(v3, 0, (v2 as u8), arg10);
            let v5 = 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::new_supply(v3, 1, (v2 as u8), arg10);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>(&v4));
            0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token::Supply>(&v5));
            0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::coin_escrow::register_supplies<T0, T1>(arg0, v2, v4, v5);
            v2 = v2 + 1;
        };
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::coin_escrow::deposit_initial_liquidity<T0, T1>(arg0, arg1, &arg2, &arg3, arg7, arg8, arg9, arg10);
        v2 = 0;
        while (v2 < arg1) {
            0x1::vector::push_back<0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::amm::LiquidityPool>(&mut v1, 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::amm::new_pool(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::coin_escrow::get_market_state<T0, T1>(arg0), (v2 as u8), *0x1::vector::borrow<u64>(&arg2, v2), *0x1::vector::borrow<u64>(&arg3, v2), arg5, arg4, arg6, arg10));
            v2 = v2 + 1;
        };
        assert_initial_reserves_consistency<T0, T1>(arg0, &v1);
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

