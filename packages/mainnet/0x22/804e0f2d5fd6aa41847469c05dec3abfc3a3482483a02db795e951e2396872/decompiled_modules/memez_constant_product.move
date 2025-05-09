module 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_constant_product {
    struct MemezConstantProduct<phantom T0, phantom T1> has store {
        memez_fun: address,
        virtual_liquidity: u64,
        target_quote_liquidity: u64,
        quote_balance: 0x2::balance::Balance<T1>,
        meme_balance: 0x2::balance::Balance<T0>,
        burner: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_burner::MemezBurner,
        meme_swap_fee: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::Fee,
        quote_swap_fee: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::Fee,
    }

    public(friend) fun new<T0, T1>(arg0: u64, arg1: u64, arg2: 0x2::balance::Balance<T0>, arg3: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::Fee, arg4: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::Fee, arg5: u64) : MemezConstantProduct<T0, T1> {
        MemezConstantProduct<T0, T1>{
            memez_fun              : @0x0,
            virtual_liquidity      : arg0,
            target_quote_liquidity : arg1,
            quote_balance          : 0x2::balance::zero<T1>(),
            meme_balance           : arg2,
            burner                 : 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_burner::new(arg5, arg1),
            meme_swap_fee          : arg3,
            quote_swap_fee         : arg4,
        }
    }

    public(friend) fun burner<T0, T1>(arg0: &MemezConstantProduct<T0, T1>) : 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_burner::MemezBurner {
        arg0.burner
    }

    public(friend) fun dump<T0, T1>(arg0: &mut MemezConstantProduct<T0, T1>, arg1: &mut 0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::take<T0>(arg0.meme_swap_fee, &mut arg2, arg4);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 > 0, 2);
        let v2 = 0x2::balance::value<T0>(&arg0.meme_balance);
        let v3 = 0x2::balance::value<T1>(&arg0.quote_balance);
        let v4 = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_burner::calculate(arg0.burner, v3);
        let v5 = 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc_up(v4, v1);
        if (0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::value(v4) != 0) {
            0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::treasury_burn<T0>(arg1, 0x2::coin::split<T0>(&mut arg2, v5, arg4));
        };
        let v6 = 0x2::coin::value<T0>(&arg2);
        assert!(v6 > 0, 2);
        assert!(v6 != 0, 1);
        assert!(v2 != 0 && arg0.virtual_liquidity + v3 != 0, 0);
        let v7 = (v6 as u128);
        0x2::balance::join<T0>(&mut arg0.meme_balance, 0x2::coin::into_balance<T0>(arg2));
        let v8 = 0x1::u64::min(((((arg0.virtual_liquidity + v3) as u128) * v7 / ((v2 as u128) + v7)) as u64), v3);
        let v9 = v8 - 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::calculate(arg0.quote_swap_fee, v8);
        assert!(v9 >= arg3, 3);
        let v10 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.quote_balance, v8), arg4);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_events::dump<T0, T1>(arg0.memez_fun, v6 + v0, v9, v0, 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::take<T1>(arg0.quote_swap_fee, &mut v10, arg4), v5, 0x2::balance::value<T1>(&arg0.quote_balance), 0x2::balance::value<T0>(&arg0.meme_balance), arg0.virtual_liquidity);
        v10
    }

    public(friend) fun dump_amount<T0, T1>(arg0: &MemezConstantProduct<T0, T1>, arg1: u64) : vector<u64> {
        if (arg1 == 0) {
            return vector[0, 0, 0, 0]
        };
        let v0 = 0x2::balance::value<T0>(&arg0.meme_balance);
        let v1 = 0x2::balance::value<T1>(&arg0.quote_balance);
        let v2 = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::calculate(arg0.meme_swap_fee, arg1);
        let v3 = arg1 - v2;
        let v4 = 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc_up(0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_burner::calculate(arg0.burner, v1), v3);
        assert!(v3 - v4 != 0, 1);
        assert!(v0 != 0 && arg0.virtual_liquidity + v1 != 0, 0);
        let v5 = ((v3 - v4) as u128);
        let v6 = 0x1::u64::min(((((arg0.virtual_liquidity + v1) as u128) * v5 / ((v0 as u128) + v5)) as u64), v1);
        let v7 = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::calculate(arg0.quote_swap_fee, v6);
        let v8 = 0x1::vector::empty<u64>();
        let v9 = &mut v8;
        0x1::vector::push_back<u64>(v9, v6 - v7);
        0x1::vector::push_back<u64>(v9, v2);
        0x1::vector::push_back<u64>(v9, v4);
        0x1::vector::push_back<u64>(v9, v7);
        v8
    }

    public(friend) fun meme_balance<T0, T1>(arg0: &MemezConstantProduct<T0, T1>) : &0x2::balance::Balance<T0> {
        &arg0.meme_balance
    }

    public(friend) fun meme_balance_mut<T0, T1>(arg0: &mut MemezConstantProduct<T0, T1>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.meme_balance
    }

    public(friend) fun pump<T0, T1>(arg0: &mut MemezConstantProduct<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (bool, 0x2::coin::Coin<T0>) {
        let v0 = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::take<T1>(arg0.quote_swap_fee, &mut arg1, arg3);
        let v1 = 0x2::coin::value<T1>(&arg1);
        assert!(v1 > 0, 2);
        let v2 = 0x2::balance::value<T0>(&arg0.meme_balance);
        assert!(v1 != 0, 1);
        assert!(arg0.virtual_liquidity + 0x2::balance::value<T1>(&arg0.quote_balance) != 0 && v2 != 0, 0);
        let v3 = (v1 as u128);
        let v4 = (((v2 as u128) * v3 / (((arg0.virtual_liquidity + 0x2::balance::value<T1>(&arg0.quote_balance)) as u128) + v3)) as u64);
        let v5 = v4 - 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::calculate(arg0.meme_swap_fee, v4);
        assert!(v5 >= arg2, 3);
        let v6 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.meme_balance, v4), arg3);
        let v7 = 0x2::balance::join<T1>(&mut arg0.quote_balance, 0x2::coin::into_balance<T1>(arg1));
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_events::pump<T0, T1>(arg0.memez_fun, v1 + v0, v5, 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::take<T0>(arg0.meme_swap_fee, &mut v6, arg3), v0, v7, 0x2::balance::value<T0>(&arg0.meme_balance), arg0.virtual_liquidity);
        (v7 >= arg0.target_quote_liquidity, v6)
    }

    public(friend) fun pump_amount<T0, T1>(arg0: &MemezConstantProduct<T0, T1>, arg1: u64) : vector<u64> {
        if (arg1 == 0) {
            return vector[0, 0, 0]
        };
        let v0 = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::calculate(arg0.quote_swap_fee, arg1);
        assert!(arg1 - v0 != 0, 1);
        assert!(arg0.virtual_liquidity + 0x2::balance::value<T1>(&arg0.quote_balance) != 0 && 0x2::balance::value<T0>(&arg0.meme_balance) != 0, 0);
        let v1 = ((arg1 - v0) as u128);
        let v2 = (((0x2::balance::value<T0>(&arg0.meme_balance) as u128) * v1 / (((arg0.virtual_liquidity + 0x2::balance::value<T1>(&arg0.quote_balance)) as u128) + v1)) as u64);
        let v3 = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::calculate(arg0.meme_swap_fee, v2);
        let v4 = 0x1::vector::empty<u64>();
        let v5 = &mut v4;
        0x1::vector::push_back<u64>(v5, v2 - v3);
        0x1::vector::push_back<u64>(v5, v0);
        0x1::vector::push_back<u64>(v5, v3);
        v4
    }

    public(friend) fun quote_balance<T0, T1>(arg0: &MemezConstantProduct<T0, T1>) : &0x2::balance::Balance<T1> {
        &arg0.quote_balance
    }

    public(friend) fun quote_balance_mut<T0, T1>(arg0: &mut MemezConstantProduct<T0, T1>) : &mut 0x2::balance::Balance<T1> {
        &mut arg0.quote_balance
    }

    public(friend) fun set_memez_fun<T0, T1>(arg0: &mut MemezConstantProduct<T0, T1>, arg1: address) {
        arg0.memez_fun = arg1;
    }

    public(friend) fun target_quote_liquidity<T0, T1>(arg0: &MemezConstantProduct<T0, T1>) : u64 {
        arg0.target_quote_liquidity
    }

    public(friend) fun virtual_liquidity<T0, T1>(arg0: &MemezConstantProduct<T0, T1>) : u64 {
        arg0.virtual_liquidity
    }

    // decompiled from Move bytecode v6
}

