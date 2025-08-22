module 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_constant_product {
    struct MemezConstantProduct<phantom T0, phantom T1> has store {
        memez_fun: address,
        inner_state: address,
        virtual_liquidity: u64,
        target_quote_liquidity: u64,
        quote_balance: 0x2::balance::Balance<T1>,
        meme_balance: 0x2::balance::Balance<T0>,
        burner: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_burner::MemezBurner,
        meme_swap_fee: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::Fee,
        quote_swap_fee: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::Fee,
        meme_referrer_fee: 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::BPS,
        quote_referrer_fee: 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::BPS,
    }

    public(friend) fun new<T0, T1>(arg0: u64, arg1: u64, arg2: 0x2::balance::Balance<T0>, arg3: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::Fee, arg4: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::Fee, arg5: 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::BPS, arg6: 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::BPS, arg7: u64) : MemezConstantProduct<T0, T1> {
        MemezConstantProduct<T0, T1>{
            memez_fun              : @0x0,
            inner_state            : @0x0,
            virtual_liquidity      : arg0,
            target_quote_liquidity : arg1,
            quote_balance          : 0x2::balance::zero<T1>(),
            meme_balance           : arg2,
            burner                 : 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_burner::new(arg7, arg1),
            meme_swap_fee          : arg3,
            quote_swap_fee         : arg4,
            meme_referrer_fee      : arg5,
            quote_referrer_fee     : arg6,
        }
    }

    public(friend) fun burner<T0, T1>(arg0: &MemezConstantProduct<T0, T1>) : 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_burner::MemezBurner {
        arg0.burner
    }

    public(friend) fun dump<T0, T1>(arg0: &mut MemezConstantProduct<T0, T1>, arg1: &mut 0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::option::Option<address>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = &mut arg2;
        let v1 = if (0x1::option::is_none<address>(&arg3)) {
            0
        } else {
            let v2 = 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc_up(arg0.meme_referrer_fee, 0x2::coin::value<T0>(v0));
            if (v2 == 0) {
                0
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v0, v2, arg5), 0x1::option::destroy_some<address>(arg3));
                v2
            }
        };
        let v3 = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::take_with_discount<T0>(arg0.meme_swap_fee, &mut arg2, arg0.meme_referrer_fee, arg5);
        let v4 = 0x2::coin::value<T0>(&arg2);
        assert!(v4 > 0, 2);
        let v5 = 0x2::balance::value<T0>(&arg0.meme_balance);
        let v6 = 0x2::balance::value<T1>(&arg0.quote_balance);
        let v7 = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_burner::calculate(arg0.burner, v6);
        let v8 = 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc_up(v7, v4);
        if (0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::value(v7) != 0) {
            0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::treasury_burn<T0>(arg1, 0x2::coin::split<T0>(&mut arg2, v8, arg5));
        };
        let v9 = 0x2::coin::value<T0>(&arg2);
        assert!(v9 > 0, 2);
        assert!(v9 != 0, 1);
        assert!(v5 != 0 && arg0.virtual_liquidity + v6 != 0, 0);
        let v10 = (v9 as u128);
        0x2::balance::join<T0>(&mut arg0.meme_balance, 0x2::coin::into_balance<T0>(arg2));
        let v11 = 0x1::u64::min(((((arg0.virtual_liquidity + v6) as u128) * v10 / ((v5 as u128) + v10)) as u64), v6);
        let v12 = v11 - 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::calculate_with_discount(arg0.quote_swap_fee, arg0.quote_referrer_fee, v11) - 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc_up(arg0.quote_referrer_fee, v11);
        assert!(v12 >= arg4, 3);
        let v13 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.quote_balance, v11), arg5);
        let v14 = &mut v13;
        let v15 = if (0x1::option::is_none<address>(&arg3)) {
            0
        } else {
            let v16 = 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc_up(arg0.quote_referrer_fee, 0x2::coin::value<T1>(v14));
            if (v16 == 0) {
                0
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(v14, v16, arg5), 0x1::option::destroy_some<address>(arg3));
                v16
            }
        };
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_events::dump<T0, T1>(arg0.memez_fun, arg0.inner_state, v9 + v3, v12, v3, 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::take_with_discount<T1>(arg0.quote_swap_fee, &mut v13, arg0.quote_referrer_fee, arg5), v8, 0x2::balance::value<T1>(&arg0.quote_balance), 0x2::balance::value<T0>(&arg0.meme_balance), arg0.virtual_liquidity, arg3, v1, v15);
        v13
    }

    public(friend) fun dump_amount<T0, T1>(arg0: &MemezConstantProduct<T0, T1>, arg1: u64) : vector<u64> {
        if (arg1 == 0) {
            return vector[0, 0, 0, 0]
        };
        let v0 = 0x2::balance::value<T0>(&arg0.meme_balance);
        let v1 = 0x2::balance::value<T1>(&arg0.quote_balance);
        let v2 = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::calculate_with_discount(arg0.meme_swap_fee, arg0.meme_referrer_fee, arg1) + 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc_up(arg0.meme_referrer_fee, arg1);
        let v3 = arg1 - v2;
        let v4 = 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc_up(0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_burner::calculate(arg0.burner, v1), v3);
        assert!(v3 - v4 != 0, 1);
        assert!(v0 != 0 && arg0.virtual_liquidity + v1 != 0, 0);
        let v5 = ((v3 - v4) as u128);
        let v6 = 0x1::u64::min(((((arg0.virtual_liquidity + v1) as u128) * v5 / ((v0 as u128) + v5)) as u64), v1);
        let v7 = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::calculate_with_discount(arg0.quote_swap_fee, arg0.quote_referrer_fee, v6) + 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc_up(arg0.quote_referrer_fee, v6);
        let v8 = 0x1::vector::empty<u64>();
        let v9 = &mut v8;
        0x1::vector::push_back<u64>(v9, v6 - v7);
        0x1::vector::push_back<u64>(v9, v2);
        0x1::vector::push_back<u64>(v9, v4);
        0x1::vector::push_back<u64>(v9, v7);
        v8
    }

    public(friend) fun inner_state<T0, T1>(arg0: &MemezConstantProduct<T0, T1>) : address {
        arg0.inner_state
    }

    public(friend) fun meme_balance<T0, T1>(arg0: &MemezConstantProduct<T0, T1>) : &0x2::balance::Balance<T0> {
        &arg0.meme_balance
    }

    public(friend) fun meme_balance_mut<T0, T1>(arg0: &mut MemezConstantProduct<T0, T1>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.meme_balance
    }

    public(friend) fun pump<T0, T1>(arg0: &mut MemezConstantProduct<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: 0x1::option::Option<address>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (bool, 0x2::coin::Coin<T0>) {
        let v0 = &mut arg1;
        let v1 = if (0x1::option::is_none<address>(&arg2)) {
            0
        } else {
            let v2 = 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc_up(arg0.quote_referrer_fee, 0x2::coin::value<T1>(v0));
            if (v2 == 0) {
                0
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(v0, v2, arg4), 0x1::option::destroy_some<address>(arg2));
                v2
            }
        };
        let v3 = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::take_with_discount<T1>(arg0.quote_swap_fee, &mut arg1, arg0.quote_referrer_fee, arg4);
        let v4 = 0x2::coin::value<T1>(&arg1);
        assert!(v4 > 0, 2);
        let v5 = 0x2::balance::value<T0>(&arg0.meme_balance);
        assert!(v4 != 0, 1);
        assert!(arg0.virtual_liquidity + 0x2::balance::value<T1>(&arg0.quote_balance) != 0 && v5 != 0, 0);
        let v6 = (v4 as u128);
        let v7 = (((v5 as u128) * v6 / (((arg0.virtual_liquidity + 0x2::balance::value<T1>(&arg0.quote_balance)) as u128) + v6)) as u64);
        let v8 = v7 - 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::calculate_with_discount(arg0.meme_swap_fee, arg0.meme_referrer_fee, v7) - 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc_up(arg0.meme_referrer_fee, v7);
        assert!(v8 >= arg3, 3);
        let v9 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.meme_balance, v7), arg4);
        let v10 = 0x2::balance::join<T1>(&mut arg0.quote_balance, 0x2::coin::into_balance<T1>(arg1));
        let v11 = &mut v9;
        let v12 = if (0x1::option::is_none<address>(&arg2)) {
            0
        } else {
            let v13 = 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc_up(arg0.meme_referrer_fee, 0x2::coin::value<T0>(v11));
            if (v13 == 0) {
                0
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v11, v13, arg4), 0x1::option::destroy_some<address>(arg2));
                v13
            }
        };
        0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_events::pump<T0, T1>(arg0.memez_fun, arg0.inner_state, v4 + v3, v8, 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::take_with_discount<T0>(arg0.meme_swap_fee, &mut v9, arg0.meme_referrer_fee, arg4), v3, v10, 0x2::balance::value<T0>(&arg0.meme_balance), arg0.virtual_liquidity, arg2, v12, v1);
        (v10 >= arg0.target_quote_liquidity, v9)
    }

    public(friend) fun pump_amount<T0, T1>(arg0: &MemezConstantProduct<T0, T1>, arg1: u64) : vector<u64> {
        if (arg1 == 0) {
            return vector[0, 0, 0]
        };
        let v0 = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::calculate_with_discount(arg0.quote_swap_fee, arg0.quote_referrer_fee, arg1) + 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc_up(arg0.quote_referrer_fee, arg1);
        assert!(arg1 - v0 != 0, 1);
        assert!(arg0.virtual_liquidity + 0x2::balance::value<T1>(&arg0.quote_balance) != 0 && 0x2::balance::value<T0>(&arg0.meme_balance) != 0, 0);
        let v1 = ((arg1 - v0) as u128);
        let v2 = (((0x2::balance::value<T0>(&arg0.meme_balance) as u128) * v1 / (((arg0.virtual_liquidity + 0x2::balance::value<T1>(&arg0.quote_balance)) as u128) + v1)) as u64);
        let v3 = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fees::calculate_with_discount(arg0.meme_swap_fee, arg0.meme_referrer_fee, v2) + 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc_up(arg0.meme_referrer_fee, v2);
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

    public(friend) fun set_inner_state<T0, T1>(arg0: &mut MemezConstantProduct<T0, T1>, arg1: address) {
        arg0.inner_state = arg1;
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

