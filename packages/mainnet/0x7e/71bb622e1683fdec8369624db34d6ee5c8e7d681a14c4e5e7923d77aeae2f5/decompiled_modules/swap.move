module 0x7e71bb622e1683fdec8369624db34d6ee5c8e7d681a14c4e5e7923d77aeae2f5::swap {
    struct LP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<LP<T0, T1>>,
    }

    entry fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg1));
        let v1 = 0x2::balance::value<T1>(0x2::coin::balance<T1>(&arg2));
        let v2 = v0 / 0x2::balance::value<T0>(&arg0.balance_a);
        let v3 = v1 / 0x2::balance::value<T1>(&arg0.balance_b);
        0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0, T1>>>(0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, 0x1::u64::min(v2, v3) * 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply)), arg3), 0x2::tx_context::sender(arg3));
        if (v2 > v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v0 - v3 * 0x2::balance::value<T0>(&arg0.balance_a), arg3), 0x2::tx_context::sender(arg3));
        } else if (v3 > v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg2, v1 - v2 * 0x2::balance::value<T1>(&arg0.balance_b), arg3), 0x2::tx_context::sender(arg3));
        };
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg2));
    }

    entry fun create_pool<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = LP<T0, T1>{dummy_field: false};
        let v1 = 0x2::balance::create_supply<LP<T0, T1>>(v0);
        let v2 = Pool<T0, T1>{
            id        : 0x2::object::new(arg2),
            balance_a : 0x2::coin::into_balance<T0>(arg0),
            balance_b : 0x2::coin::into_balance<T1>(arg1),
            lp_supply : v1,
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0, T1>>>(0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut v1, 0x1::u64::sqrt(0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg0)) * 0x2::balance::value<T1>(0x2::coin::balance<T1>(&arg1)))), arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<LP<T0, T1>>(0x2::coin::balance<LP<T0, T1>>(&arg1));
        let v1 = 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply);
        0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP<T0, T1>>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance_a, 0x2::balance::value<T1>(&arg0.balance_b) * v0 / v1, arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.balance_b, 0x2::balance::value<T0>(&arg0.balance_a) * v0 / v1, arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun swap_a_2_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.balance_b, 0x2::balance::value<T1>(&arg0.balance_b) - 0x2::balance::value<T0>(&arg0.balance_a) * 0x2::balance::value<T1>(&arg0.balance_b) / (0x2::balance::value<T0>(&arg0.balance_a) + 0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg1))), arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun swap_b_2_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance_a, 0x2::balance::value<T0>(&arg0.balance_a) - 0x2::balance::value<T0>(&arg0.balance_a) * 0x2::balance::value<T1>(&arg0.balance_b) / (0x2::balance::value<T1>(&arg0.balance_b) + 0x2::balance::value<T1>(0x2::coin::balance<T1>(&arg1))), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

