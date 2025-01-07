module 0x1d8242d619fd74cf60ad63b0bab612c8f9bd5c818dcce4ccd65135d4c2f38063::swap {
    struct LPCoin<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct LiquidityPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coin_a_balance: 0x2::balance::Balance<T0>,
        coin_b_balance: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<LPCoin<T0, T1>>,
    }

    public fun create_liquidity_pool<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = LPCoin<T0, T1>{dummy_field: false};
        let v1 = 0x2::balance::create_supply<LPCoin<T0, T1>>(v0);
        let v2 = LiquidityPool<T0, T1>{
            id             : 0x2::object::new(arg2),
            coin_a_balance : 0x2::coin::into_balance<T0>(arg0),
            coin_b_balance : 0x2::coin::into_balance<T1>(arg1),
            lp_supply      : v1,
        };
        0x2::transfer::share_object<LiquidityPool<T0, T1>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<LPCoin<T0, T1>>>(0x2::coin::from_balance<LPCoin<T0, T1>>(0x2::balance::increase_supply<LPCoin<T0, T1>>(&mut v1, 0x2::math::sqrt(0x2::coin::value<T0>(&arg0) * 0x2::coin::value<T1>(&arg1))), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun remove_liquidity<T0, T1>(arg0: 0x2::coin::Coin<LPCoin<T0, T1>>, arg1: &mut LiquidityPool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<LPCoin<T0, T1>>(&arg0);
        let v1 = 0x2::balance::value<T0>(&arg1.coin_a_balance);
        let v2 = 0x2::balance::value<T1>(&arg1.coin_b_balance);
        let v3 = 0x2::balance::supply_value<LPCoin<T0, T1>>(&arg1.lp_supply);
        0x2::balance::decrease_supply<LPCoin<T0, T1>>(&mut arg1.lp_supply, 0x2::coin::into_balance<LPCoin<T0, T1>>(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.coin_a_balance, v1 - v0 * v1 / v3), arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.coin_b_balance, v2 - v0 * v2 / v3), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun supply_liquidity<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut LiquidityPool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::supply_value<LPCoin<T0, T1>>(&arg2.lp_supply);
        let v1 = 0x2::coin::into_balance<T0>(arg0);
        let v2 = 0x2::coin::into_balance<T1>(arg1);
        0x2::balance::join<T0>(&mut arg2.coin_a_balance, v1);
        0x2::balance::join<T1>(&mut arg2.coin_b_balance, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<LPCoin<T0, T1>>>(0x2::coin::from_balance<LPCoin<T0, T1>>(0x2::balance::increase_supply<LPCoin<T0, T1>>(&mut arg2.lp_supply, 0x2::math::min(0x2::balance::value<T0>(&v1) * v0 / 0x2::balance::value<T0>(&arg2.coin_a_balance), 0x2::balance::value<T1>(&v2) * v0 / 0x2::balance::value<T1>(&arg2.coin_b_balance))), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun swap_a_for_b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut LiquidityPool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg1.coin_a_balance, 0x2::coin::into_balance<T0>(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.coin_b_balance, 0x2::balance::value<T1>(&arg1.coin_b_balance) - 0x2::balance::supply_value<LPCoin<T0, T1>>(&arg1.lp_supply) / (0x2::balance::value<T0>(&arg1.coin_a_balance) + 0x2::coin::value<T0>(&arg0))), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun swap_b_for_a<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut LiquidityPool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T1>(&mut arg1.coin_b_balance, 0x2::coin::into_balance<T1>(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.coin_a_balance, 0x2::balance::value<T0>(&arg1.coin_a_balance) - 0x2::balance::supply_value<LPCoin<T0, T1>>(&arg1.lp_supply) / (0x2::balance::value<T1>(&arg1.coin_b_balance) + 0x2::coin::value<T1>(&arg0))), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

