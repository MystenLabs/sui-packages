module 0x88302c64785c8c12229c43d65e2bcdf96b3cb27ec28f53582463f462be4e9299::gunksd {
    struct LPCoin<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct LiquidityPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coin_a_balance: 0x2::balance::Balance<T0>,
        coin_b_balance: 0x2::balance::Balance<T1>,
        lp_coin_supply: 0x2::balance::Supply<LPCoin<T0, T1>>,
        initial_lp_coin_reserve: 0x2::balance::Balance<LPCoin<T0, T1>>,
    }

    public entry fun create_liquidity_pool<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::math::sqrt(0x2::coin::value<T0>(&arg0) * 0x2::coin::value<T1>(&arg1));
        assert!(v0 >= 1000, 1);
        let v1 = LPCoin<T0, T1>{dummy_field: false};
        let v2 = 0x2::balance::create_supply<LPCoin<T0, T1>>(v1);
        let v3 = LiquidityPool<T0, T1>{
            id                      : 0x2::object::new(arg2),
            coin_a_balance          : 0x2::coin::into_balance<T0>(arg0),
            coin_b_balance          : 0x2::coin::into_balance<T1>(arg1),
            lp_coin_supply          : v2,
            initial_lp_coin_reserve : 0x2::balance::increase_supply<LPCoin<T0, T1>>(&mut v2, 1000),
        };
        0x2::transfer::share_object<LiquidityPool<T0, T1>>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<LPCoin<T0, T1>>>(0x2::coin::from_balance<LPCoin<T0, T1>>(0x2::balance::increase_supply<LPCoin<T0, T1>>(&mut v2, v0 - 1000), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun remove_liquidity<T0, T1>(arg0: 0x2::coin::Coin<LPCoin<T0, T1>>, arg1: &mut LiquidityPool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<LPCoin<T0, T1>>(&arg0);
        assert!(v0 > 0, 1);
        let v1 = 0x2::balance::supply_value<LPCoin<T0, T1>>(&arg1.lp_coin_supply);
        0x2::balance::decrease_supply<LPCoin<T0, T1>>(&mut arg1.lp_coin_supply, 0x2::coin::into_balance<LPCoin<T0, T1>>(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.coin_a_balance, v0 * 0x2::balance::value<T0>(&arg1.coin_a_balance) / v1), arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.coin_b_balance, v0 * 0x2::balance::value<T1>(&arg1.coin_b_balance) / v1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun supply_liquidity<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut LiquidityPool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 1);
        assert!(v1 > 0, 1);
        let v2 = 0x2::balance::supply_value<LPCoin<T0, T1>>(&arg2.lp_coin_supply);
        0x2::balance::join<T0>(&mut arg2.coin_a_balance, 0x2::coin::into_balance<T0>(arg0));
        0x2::balance::join<T1>(&mut arg2.coin_b_balance, 0x2::coin::into_balance<T1>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<LPCoin<T0, T1>>>(0x2::coin::from_balance<LPCoin<T0, T1>>(0x2::balance::increase_supply<LPCoin<T0, T1>>(&mut arg2.lp_coin_supply, 0x2::math::min(v0 * v2 / 0x2::balance::value<T0>(&arg2.coin_a_balance), v1 * v2 / 0x2::balance::value<T1>(&arg2.coin_b_balance))), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun swap_exact_a_for_b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut LiquidityPool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1.coin_a_balance);
        let v1 = 0x2::balance::value<T1>(&arg1.coin_b_balance);
        let v2 = v1 * v0 / (0x2::coin::value<T0>(&arg0) + v0);
        assert!(arg2 > 0, 3);
        assert!(v1 - v2 >= arg2, 2);
        0x2::balance::join<T0>(&mut arg1.coin_a_balance, 0x2::coin::into_balance<T0>(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.coin_b_balance, v1 - v2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_exact_b_for_a<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut LiquidityPool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1.coin_a_balance);
        let v1 = 0x2::balance::value<T1>(&arg1.coin_b_balance);
        let v2 = v1 * v0 / (0x2::coin::value<T1>(&arg0) + v1);
        assert!(arg2 > 0, 3);
        assert!(v0 - v2 >= arg2, 2);
        0x2::balance::join<T1>(&mut arg1.coin_b_balance, 0x2::coin::into_balance<T1>(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.coin_a_balance, v0 - v2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

