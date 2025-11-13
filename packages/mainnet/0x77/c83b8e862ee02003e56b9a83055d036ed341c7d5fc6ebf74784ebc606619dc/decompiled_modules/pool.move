module 0x77c83b8e862ee02003e56b9a83055d036ed341c7d5fc6ebf74784ebc606619dc::pool {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        reserve_a: 0x2::balance::Balance<T0>,
        reserve_b: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<0x77c83b8e862ee02003e56b9a83055d036ed341c7d5fc6ebf74784ebc606619dc::lp_coin::LP<T0, T1>>,
        locked_lp: 0x2::balance::Balance<0x77c83b8e862ee02003e56b9a83055d036ed341c7d5fc6ebf74784ebc606619dc::lp_coin::LP<T0, T1>>,
        fee_balance_a: 0x2::balance::Balance<T0>,
        fee_balance_b: 0x2::balance::Balance<T1>,
        creator: address,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0x77c83b8e862ee02003e56b9a83055d036ed341c7d5fc6ebf74784ebc606619dc::lp_coin::LP<T0, T1>>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let (v2, v3, v4) = get_amounts<T0, T1>(arg0);
        let v5 = quote(v0, v2, v3);
        let (v6, v7) = if (v5 <= v1) {
            (v0, v5)
        } else {
            let v8 = quote(v1, v3, v2);
            assert!(v8 <= v0, 1);
            (v8, v1)
        };
        let v9 = v6 * v4 / v2;
        let v10 = v7 * v4 / v3;
        let v11 = if (v9 < v10) {
            v9
        } else {
            v10
        };
        assert!(v11 >= arg3, 2);
        0x2::balance::join<T0>(&mut arg0.reserve_a, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v6, arg4)));
        0x2::balance::join<T1>(&mut arg0.reserve_b, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v7, arg4)));
        (arg1, arg2, 0x2::coin::from_balance<0x77c83b8e862ee02003e56b9a83055d036ed341c7d5fc6ebf74784ebc606619dc::lp_coin::LP<T0, T1>>(0x2::balance::increase_supply<0x77c83b8e862ee02003e56b9a83055d036ed341c7d5fc6ebf74784ebc606619dc::lp_coin::LP<T0, T1>>(&mut arg0.lp_supply, v11), arg4))
    }

    public fun claim_fees<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 4);
        let v0 = 0x2::balance::value<T0>(&arg0.fee_balance_a);
        let v1 = 0x2::balance::value<T1>(&arg0.fee_balance_b);
        let v2 = if (v0 > 0) {
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.fee_balance_a, v0), arg1)
        } else {
            0x2::coin::zero<T0>(arg1)
        };
        let v3 = if (v1 > 0) {
            0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.fee_balance_b, v1), arg1)
        } else {
            0x2::coin::zero<T1>(arg1)
        };
        (v2, v3)
    }

    public fun create_pool<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : (Pool<T0, T1>, 0x2::coin::Coin<0x77c83b8e862ee02003e56b9a83055d036ed341c7d5fc6ebf74784ebc606619dc::lp_coin::LP<T0, T1>>) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0 && v1 > 0, 1);
        let v2 = sqrt_u128((v0 as u128) * (v1 as u128));
        assert!(v2 > 1000, 0);
        let v3 = 0x2::balance::create_supply<0x77c83b8e862ee02003e56b9a83055d036ed341c7d5fc6ebf74784ebc606619dc::lp_coin::LP<T0, T1>>(0x77c83b8e862ee02003e56b9a83055d036ed341c7d5fc6ebf74784ebc606619dc::lp_coin::create_witness<T0, T1>());
        let v4 = 0x2::balance::increase_supply<0x77c83b8e862ee02003e56b9a83055d036ed341c7d5fc6ebf74784ebc606619dc::lp_coin::LP<T0, T1>>(&mut v3, v2);
        let v5 = Pool<T0, T1>{
            id            : 0x2::object::new(arg2),
            reserve_a     : 0x2::coin::into_balance<T0>(arg0),
            reserve_b     : 0x2::coin::into_balance<T1>(arg1),
            lp_supply     : v3,
            locked_lp     : 0x2::balance::split<0x77c83b8e862ee02003e56b9a83055d036ed341c7d5fc6ebf74784ebc606619dc::lp_coin::LP<T0, T1>>(&mut v4, 1000),
            fee_balance_a : 0x2::balance::zero<T0>(),
            fee_balance_b : 0x2::balance::zero<T1>(),
            creator       : 0x2::tx_context::sender(arg2),
        };
        (v5, 0x2::coin::from_balance<0x77c83b8e862ee02003e56b9a83055d036ed341c7d5fc6ebf74784ebc606619dc::lp_coin::LP<T0, T1>>(v4, arg2))
    }

    public fun creator<T0, T1>(arg0: &Pool<T0, T1>) : address {
        arg0.creator
    }

    public fun fee_balance_a<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.fee_balance_a)
    }

    public fun fee_balance_b<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.fee_balance_b)
    }

    fun get_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg0 > 0) {
            if (arg1 > 0) {
                arg2 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        arg0 * arg2 / (arg1 + arg0)
    }

    public fun get_amounts<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_a), 0x2::balance::value<T1>(&arg0.reserve_b), 0x2::balance::supply_value<0x77c83b8e862ee02003e56b9a83055d036ed341c7d5fc6ebf74784ebc606619dc::lp_coin::LP<T0, T1>>(&arg0.lp_supply))
    }

    public fun locked_lp<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<0x77c83b8e862ee02003e56b9a83055d036ed341c7d5fc6ebf74784ebc606619dc::lp_coin::LP<T0, T1>>(&arg0.locked_lp)
    }

    public fun lp_supply<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::supply_value<0x77c83b8e862ee02003e56b9a83055d036ed341c7d5fc6ebf74784ebc606619dc::lp_coin::LP<T0, T1>>(&arg0.lp_supply)
    }

    fun quote(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg0 > 0) {
            if (arg1 > 0) {
                arg2 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        arg0 * arg2 / arg1
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<0x77c83b8e862ee02003e56b9a83055d036ed341c7d5fc6ebf74784ebc606619dc::lp_coin::LP<T0, T1>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<0x77c83b8e862ee02003e56b9a83055d036ed341c7d5fc6ebf74784ebc606619dc::lp_coin::LP<T0, T1>>(&arg1);
        let (_, _, v3) = get_amounts<T0, T1>(arg0);
        let v4 = v0 * 0x2::balance::value<T0>(&arg0.reserve_a) / v3;
        let v5 = v0 * 0x2::balance::value<T1>(&arg0.reserve_b) / v3;
        assert!(v4 >= arg2 && v5 >= arg3, 2);
        0x2::balance::decrease_supply<0x77c83b8e862ee02003e56b9a83055d036ed341c7d5fc6ebf74784ebc606619dc::lp_coin::LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<0x77c83b8e862ee02003e56b9a83055d036ed341c7d5fc6ebf74784ebc606619dc::lp_coin::LP<T0, T1>>(arg1));
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_a, v4), arg4), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_b, v5), arg4))
    }

    public fun reserve_a<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.reserve_a)
    }

    public fun reserve_b<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.reserve_b)
    }

    public fun share_pool<T0, T1>(arg0: Pool<T0, T1>) {
        0x2::transfer::share_object<Pool<T0, T1>>(arg0);
    }

    fun sqrt_u128(arg0: u128) : u64 {
        if (arg0 < 4) {
            if (arg0 == 0) {
                0
            } else {
                1
            }
        } else {
            let v1 = arg0 / 2 + 1;
            while (v1 < arg0) {
                let v2 = arg0 / v1 + v1;
                v1 = v2 / 2;
            };
            (arg0 as u64)
        }
    }

    public fun swap_a_for_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3);
        let (v1, v2, _) = get_amounts<T0, T1>(arg0);
        let v4 = v0 * 1 / 100;
        let v5 = get_amount_out(v0 - v4, v1, v2);
        assert!(v5 >= arg2, 2);
        let v6 = 0x2::coin::into_balance<T0>(arg1);
        0x2::balance::join<T0>(&mut arg0.fee_balance_a, 0x2::balance::split<T0>(&mut v6, v4));
        0x2::balance::join<T0>(&mut arg0.reserve_a, v6);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_b, v5), arg3)
    }

    public fun swap_b_for_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 3);
        let (v1, v2, _) = get_amounts<T0, T1>(arg0);
        let v4 = v0 * 1 / 100;
        let v5 = get_amount_out(v0 - v4, v2, v1);
        assert!(v5 >= arg2, 2);
        let v6 = 0x2::coin::into_balance<T1>(arg1);
        0x2::balance::join<T1>(&mut arg0.fee_balance_b, 0x2::balance::split<T1>(&mut v6, v4));
        0x2::balance::join<T1>(&mut arg0.reserve_b, v6);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_a, v5), arg3)
    }

    // decompiled from Move bytecode v6
}

