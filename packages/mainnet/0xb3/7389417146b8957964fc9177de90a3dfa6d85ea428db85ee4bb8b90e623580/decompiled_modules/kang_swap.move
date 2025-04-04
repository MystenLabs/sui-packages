module 0xb37389417146b8957964fc9177de90a3dfa6d85ea428db85ee4bb8b90e623580::kang_swap {
    struct LiquidityToken<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        supply_lt: 0x2::balance::Supply<LiquidityToken<T0, T1>>,
    }

    public entry fun create<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::math::sqrt(0x2::coin::value<T0>(&arg0) * 0x2::coin::value<T1>(&arg1));
        assert!(v0 > 0, 0);
        let v1 = LiquidityToken<T0, T1>{dummy_field: false};
        let v2 = 0x2::balance::create_supply<LiquidityToken<T0, T1>>(v1);
        let v3 = Pool<T0, T1>{
            id        : 0x2::object::new(arg2),
            balance_a : 0x2::coin::into_balance<T0>(arg0),
            balance_b : 0x2::coin::into_balance<T1>(arg1),
            supply_lt : v2,
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<LiquidityToken<T0, T1>>>(0x2::coin::from_balance<LiquidityToken<T0, T1>>(0x2::balance::increase_supply<LiquidityToken<T0, T1>>(&mut v2, v0), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun provide<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::supply_value<LiquidityToken<T0, T1>>(&arg0.supply_lt);
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<LiquidityToken<T0, T1>>>(0x2::coin::from_balance<LiquidityToken<T0, T1>>(0x2::balance::increase_supply<LiquidityToken<T0, T1>>(&mut arg0.supply_lt, 0x2::math::min(v0 * 0x2::coin::value<T0>(&arg1) / 0x2::balance::value<T0>(&arg0.balance_a), v0 * 0x2::coin::value<T1>(&arg2) / 0x2::balance::value<T1>(&arg0.balance_b))), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun remove<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LiquidityToken<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<LiquidityToken<T0, T1>>(&arg1);
        let v1 = 0x2::balance::supply_value<LiquidityToken<T0, T1>>(&arg0.supply_lt);
        0x2::balance::decrease_supply<LiquidityToken<T0, T1>>(&mut arg0.supply_lt, 0x2::coin::into_balance<LiquidityToken<T0, T1>>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance_a, 0x2::balance::value<T0>(&arg0.balance_a) * v0 / v1), arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance_b, 0x2::balance::value<T1>(&arg0.balance_b) * v0 / v1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_a_to_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T1>(&arg0.balance_b);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = v0 * v1 / (0x2::balance::value<T0>(&arg0.balance_a) + v1);
        assert!(v0 > v2, 1);
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance_b, v2), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_b_to_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0.balance_a);
        let v1 = 0x2::coin::value<T1>(&arg1);
        let v2 = v0 * v1 / (0x2::balance::value<T1>(&arg0.balance_b) + v1);
        assert!(v0 > v2, 1);
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance_a, v2), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

