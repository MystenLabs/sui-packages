module 0xb8b4352b47596460386ab5e07244881ca5a1007b507dec12e7022a092d78fe2a::vv1133_swap {
    struct LP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coin_a_bal: 0x2::balance::Balance<T0>,
        coin_b_bal: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<LP<T0, T1>>,
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0 && v1 > 0, 1);
        let v2 = 0x2::balance::value<T0>(&arg0.coin_a_bal);
        let v3 = 0x2::balance::value<T1>(&arg0.coin_b_bal);
        0x2::balance::join<T0>(&mut arg0.coin_a_bal, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.coin_b_bal, 0x2::coin::into_balance<T1>(arg2));
        let v4 = v0 / v2;
        let v5 = v1 / v3;
        let (v6, v7) = if (v4 >= v5) {
            let v8 = v5 * v2;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a_bal, v0 - v8), arg3), 0x2::tx_context::sender(arg3));
            (v8, v1)
        } else {
            let v9 = v4 * v3;
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b_bal, v1 - v9), arg3), 0x2::tx_context::sender(arg3));
            (v0, v9)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0, T1>>>(0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, 0x2::math::sqrt((v0 + v6) * (v1 + v7)) - 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply)), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun create_pool<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0 && v1 > 0, 1);
        let v2 = LP<T0, T1>{dummy_field: false};
        let v3 = 0x2::balance::create_supply<LP<T0, T1>>(v2);
        let v4 = Pool<T0, T1>{
            id         : 0x2::object::new(arg2),
            coin_a_bal : 0x2::coin::into_balance<T0>(arg0),
            coin_b_bal : 0x2::coin::into_balance<T1>(arg1),
            lp_supply  : v3,
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0, T1>>>(0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut v3, 0x2::math::sqrt(v0 * v1)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<LP<T0, T1>>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = v0 / 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply);
        0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP<T0, T1>>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a_bal, v1 * 0x2::balance::value<T0>(&arg0.coin_a_bal)), arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b_bal, v1 * 0x2::balance::value<T1>(&arg0.coin_b_bal)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_coin_a_to_coin_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::balance::value<T0>(&arg0.coin_a_bal);
        let v2 = 0x2::balance::value<T1>(&arg0.coin_b_bal);
        assert!(v0 > 0, 1);
        0x2::balance::join<T0>(&mut arg0.coin_a_bal, 0x2::coin::into_balance<T0>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b_bal, v2 - v1 * v2 / (v1 + v0)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_coin_b_to_coin_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        let v1 = 0x2::balance::value<T0>(&arg0.coin_a_bal);
        let v2 = 0x2::balance::value<T1>(&arg0.coin_b_bal);
        assert!(v0 > 0, 1);
        0x2::balance::join<T1>(&mut arg0.coin_b_bal, 0x2::coin::into_balance<T1>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a_bal, v1 - v2 * v1 / (v2 + v0)), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

