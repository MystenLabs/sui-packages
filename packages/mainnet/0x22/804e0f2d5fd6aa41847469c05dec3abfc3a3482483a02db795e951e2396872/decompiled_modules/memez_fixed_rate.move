module 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fixed_rate {
    struct FixedRate<phantom T0, phantom T1> has store {
        memez_fun: address,
        quote_raise_amount: u64,
        meme_sale_amount: u64,
        meme_swap_fee: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::Fee,
        quote_swap_fee: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::Fee,
        meme_balance: 0x2::balance::Balance<T0>,
        quote_balance: 0x2::balance::Balance<T1>,
    }

    public(friend) fun dump<T0, T1>(arg0: &mut FixedRate<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::take<T0>(arg0.meme_swap_fee, &mut arg1, arg2);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0, 2);
        let v2 = 0x1::u64::min(0x2::balance::value<T1>(&arg0.quote_balance), 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::u64::mul_div_down(v1, arg0.quote_raise_amount, arg0.meme_sale_amount));
        0x2::balance::join<T0>(&mut arg0.meme_balance, 0x2::coin::into_balance<T0>(arg1));
        let v3 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.quote_balance, v2), arg2);
        let v4 = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::take<T1>(arg0.quote_swap_fee, &mut v3, arg2);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_events::dump<T0, T1>(arg0.memez_fun, v1 + v0, v2 - v4, v0, v4, 0, 0x2::balance::value<T1>(&arg0.quote_balance), 0x2::balance::value<T0>(&arg0.meme_balance), 0);
        v3
    }

    public(friend) fun pump<T0, T1>(arg0: &mut FixedRate<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : (bool, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 2);
        let v1 = amount_before_fee(arg0.quote_raise_amount - 0x2::balance::value<T1>(&arg0.quote_balance), 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::value(arg0.quote_swap_fee));
        let v2 = if (v0 > v1) {
            0x2::coin::split<T1>(&mut arg1, v0 - v1, arg2)
        } else {
            0x2::coin::zero<T1>(arg2)
        };
        let v3 = 0x2::coin::value<T1>(&arg1);
        let v4 = 0x1::u64::min(0x2::balance::value<T0>(&arg0.meme_balance), 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::u64::mul_div_down(v3, arg0.meme_sale_amount, arg0.quote_raise_amount));
        let v5 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.meme_balance, v4), arg2);
        let v6 = 0x2::balance::join<T1>(&mut arg0.quote_balance, 0x2::coin::into_balance<T1>(arg1));
        let v7 = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::take<T0>(arg0.meme_swap_fee, &mut v5, arg2);
        0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_events::pump<T0, T1>(arg0.memez_fun, v3, v4 - v7, v7, 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::take<T1>(arg0.quote_swap_fee, &mut arg1, arg2), v6, 0x2::balance::value<T0>(&arg0.meme_balance), 0);
        (v6 >= arg0.quote_raise_amount, v2, v5)
    }

    fun amount_before_fee(arg0: u64, arg1: u64) : u64 {
        let v0 = 10000;
        0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::u64::mul_div_up(arg0, v0, v0 - arg1)
    }

    public(friend) fun dump_amount<T0, T1>(arg0: &FixedRate<T0, T1>, arg1: u64, arg2: u64) : vector<u64> {
        if (arg1 == 0) {
            return vector[0, 0, 0]
        };
        let v0 = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::calculate(arg0.meme_swap_fee, arg1);
        let v1 = 0x1::u64::min(0x2::balance::value<T1>(&arg0.quote_balance), 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::u64::mul_div_down(arg1 - v0, arg0.quote_raise_amount, arg0.meme_sale_amount + arg2));
        let v2 = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::calculate(arg0.quote_swap_fee, v1);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, v1 - v2);
        0x1::vector::push_back<u64>(v4, v0);
        0x1::vector::push_back<u64>(v4, v2);
        v3
    }

    public(friend) fun increase_meme_available<T0, T1>(arg0: &mut FixedRate<T0, T1>, arg1: 0x2::balance::Balance<T0>) : u64 {
        arg0.meme_sale_amount = arg0.meme_sale_amount + 0x2::balance::value<T0>(&arg1);
        0x2::balance::join<T0>(&mut arg0.meme_balance, arg1)
    }

    public(friend) fun meme_balance<T0, T1>(arg0: &FixedRate<T0, T1>) : &0x2::balance::Balance<T0> {
        &arg0.meme_balance
    }

    public(friend) fun meme_balance_mut<T0, T1>(arg0: &mut FixedRate<T0, T1>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.meme_balance
    }

    public(friend) fun meme_sale_amount<T0, T1>(arg0: &FixedRate<T0, T1>) : u64 {
        arg0.meme_sale_amount
    }

    public(friend) fun new<T0, T1>(arg0: u64, arg1: 0x2::balance::Balance<T0>, arg2: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::Fee, arg3: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::Fee) : FixedRate<T0, T1> {
        assert!(arg0 != 0, 13906834311782334463);
        FixedRate<T0, T1>{
            memez_fun          : @0x0,
            quote_raise_amount : arg0,
            meme_sale_amount   : 0x2::balance::value<T0>(&arg1),
            meme_swap_fee      : arg2,
            quote_swap_fee     : arg3,
            meme_balance       : arg1,
            quote_balance      : 0x2::balance::zero<T1>(),
        }
    }

    public(friend) fun pump_amount<T0, T1>(arg0: &FixedRate<T0, T1>, arg1: u64, arg2: u64) : vector<u64> {
        if (arg1 == 0) {
            return vector[0, 0, 0, 0]
        };
        if (0x2::balance::value<T1>(&arg0.quote_balance) >= arg0.quote_raise_amount) {
            let v0 = 0x1::vector::empty<u64>();
            let v1 = &mut v0;
            0x1::vector::push_back<u64>(v1, arg1);
            0x1::vector::push_back<u64>(v1, 0);
            0x1::vector::push_back<u64>(v1, 0);
            0x1::vector::push_back<u64>(v1, 0);
            return v0
        };
        let v2 = amount_before_fee(arg0.quote_raise_amount - 0x2::balance::value<T1>(&arg0.quote_balance), 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::value(arg0.quote_swap_fee));
        let v3 = if (arg1 > v2) {
            arg1 - v2
        } else {
            0
        };
        let v4 = arg1 - v3;
        let v5 = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::calculate(arg0.quote_swap_fee, v4);
        let v6 = 0x1::u64::min(0x2::balance::value<T0>(&arg0.meme_balance) + arg2, 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::u64::mul_div_down(v4 - v5, arg0.meme_sale_amount + arg2, arg0.quote_raise_amount));
        let v7 = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fees::calculate(arg0.meme_swap_fee, v6);
        let v8 = 0x1::vector::empty<u64>();
        let v9 = &mut v8;
        0x1::vector::push_back<u64>(v9, v3);
        0x1::vector::push_back<u64>(v9, v6 - v7);
        0x1::vector::push_back<u64>(v9, v5);
        0x1::vector::push_back<u64>(v9, v7);
        v8
    }

    public(friend) fun quote_balance<T0, T1>(arg0: &FixedRate<T0, T1>) : &0x2::balance::Balance<T1> {
        &arg0.quote_balance
    }

    public(friend) fun quote_balance_mut<T0, T1>(arg0: &mut FixedRate<T0, T1>) : &mut 0x2::balance::Balance<T1> {
        &mut arg0.quote_balance
    }

    public(friend) fun quote_raise_amount<T0, T1>(arg0: &FixedRate<T0, T1>) : u64 {
        arg0.quote_raise_amount
    }

    public(friend) fun set_memez_fun<T0, T1>(arg0: &mut FixedRate<T0, T1>, arg1: address) {
        arg0.memez_fun = arg1;
    }

    // decompiled from Move bytecode v6
}

