module 0xe9e48d7743aaf44d44828ee1a50c70bb1ab48f1b4379d733ca9868fcfafc928f::swap_ai {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>) {
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg2));
    }

    public entry fun create_pool<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0, T1>{
            id        : 0x2::object::new(arg0),
            balance_a : 0x2::balance::zero<T0>(),
            balance_b : 0x2::balance::zero<T1>(),
        };
        0x2::transfer::public_transfer<Pool<T0, T1>>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_a_to_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance_b, 0x2::balance::value<T1>(&arg0.balance_b) * v0 / (0x2::balance::value<T0>(&arg0.balance_a) + v0)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_b_to_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance_a, 0x2::balance::value<T0>(&arg0.balance_a) * v0 / (0x2::balance::value<T1>(&arg0.balance_b) + v0)), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

