module 0xb138d8116faa78385dd3c8d99d8d8e25fd9d22ea4c76473b90119976ed0c7d71::ydamw22 {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        token_a: 0x2::balance::Balance<T0>,
        token_b: 0x2::balance::Balance<T1>,
        lp: 0x2::balance::Supply<LP<T0, T1>>,
    }

    struct LP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0.token_a);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = 0x2::coin::value<T1>(&arg2);
        if (v0 != 0 && v0 != 0) {
            assert!(v0 / 0x2::balance::value<T1>(&arg0.token_b) == v1 / v2, 0);
        };
        0x2::balance::join<T0>(&mut arg0.token_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.token_b, 0x2::coin::into_balance<T1>(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0, T1>>>(0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp, 0x1::u64::sqrt(v1 * v2)), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun create_pool<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LP<T0, T1>{dummy_field: false};
        let v1 = Pool<T0, T1>{
            id      : 0x2::object::new(arg0),
            token_a : 0x2::balance::zero<T0>(),
            token_b : 0x2::balance::zero<T1>(),
            lp      : 0x2::balance::create_supply<LP<T0, T1>>(v0),
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v1);
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<LP<T0, T1>>(&arg1);
        let v1 = 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp);
        0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lp, 0x2::coin::into_balance<LP<T0, T1>>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.token_a, 0x2::balance::value<T0>(&arg0.token_a) * v0 / v1, arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.token_b, 0x2::balance::value<T1>(&arg0.token_b) * v0 / v1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_a_to_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0.token_a);
        let v1 = 0x2::balance::value<T1>(&arg0.token_b);
        0x2::balance::join<T0>(&mut arg0.token_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.token_b, v1 - v0 * v1 / (0x2::coin::value<T0>(&arg1) + v0)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_b_to_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0.token_a);
        let v1 = 0x2::balance::value<T1>(&arg0.token_b);
        0x2::balance::join<T1>(&mut arg0.token_b, 0x2::coin::into_balance<T1>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_a, v0 - v0 * v1 / (0x2::coin::value<T1>(&arg1) + v1)), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

