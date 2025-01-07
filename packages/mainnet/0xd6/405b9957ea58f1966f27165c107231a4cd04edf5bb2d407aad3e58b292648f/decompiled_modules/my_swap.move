module 0xd6405b9957ea58f1966f27165c107231a4cd04edf5bb2d407aad3e58b292648f::my_swap {
    struct LiquidPool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        coin_a: 0x2::coin::Coin<T0>,
        coin_b: 0x2::coin::Coin<T1>,
        reserve_a: u64,
        reserve_b: u64,
        liquidity: u64,
    }

    struct LiquidityToken<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut LiquidPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg1));
        let v1 = 0x2::balance::value<T1>(0x2::coin::balance<T1>(&arg2));
        let v2 = v0 * 1000000 / arg0.reserve_a;
        let v3 = v1 * 1000000 / arg0.reserve_a;
        let v4 = 0x1::u64::min(v2, v3) * arg0.liquidity / 1000000;
        let v5 = LiquidityToken<T0, T1>{
            id     : 0x2::object::new(arg3),
            amount : v4,
        };
        0x2::transfer::public_transfer<LiquidityToken<T0, T1>>(v5, 0x2::tx_context::sender(arg3));
        if (v2 > v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v0 - v3 * arg0.reserve_a / 1000000, arg3), 0x2::tx_context::sender(arg3));
        } else if (v3 > v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg2, v1 - v2 * arg0.reserve_b / 1000000, arg3), 0x2::tx_context::sender(arg3));
        };
        arg0.liquidity = v4 + arg0.liquidity;
        0x2::coin::join<T0>(&mut arg0.coin_a, arg1);
        0x2::coin::join<T1>(&mut arg0.coin_b, arg2);
        arg0.reserve_a = arg0.reserve_a + v0;
        arg0.reserve_b = arg0.reserve_b + v1;
    }

    entry fun create_pool<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg0));
        let v1 = 0x2::balance::value<T1>(0x2::coin::balance<T1>(&arg1));
        let v2 = 0x2::math::sqrt(v0 * v1);
        let v3 = LiquidPool<T0, T1>{
            id        : 0x2::object::new(arg2),
            coin_a    : arg0,
            coin_b    : arg1,
            reserve_a : v0,
            reserve_b : v1,
            liquidity : v2,
        };
        let v4 = LiquidityToken<T0, T1>{
            id     : 0x2::object::new(arg2),
            amount : v2,
        };
        0x2::transfer::public_transfer<LiquidityToken<T0, T1>>(v4, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_share_object<LiquidPool<T0, T1>>(v3);
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut LiquidPool<T0, T1>, arg1: LiquidityToken<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let LiquidityToken {
            id     : v0,
            amount : v1,
        } = arg1;
        0x2::object::delete(v0);
        let v2 = v1 * 1000000 / arg0.liquidity;
        let v3 = arg0.reserve_a * v2 / 1000000;
        let v4 = arg0.reserve_b * v2 / 1000000;
        arg0.reserve_a = arg0.reserve_a - v3;
        arg0.reserve_b = arg0.reserve_b - v4;
        arg0.liquidity = arg0.liquidity - v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.coin_a, v3, arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0.coin_b, v4, arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun swap_a_for_b<T0, T1>(arg0: &mut LiquidPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg1));
        assert!(v0 > 0, 0);
        let v1 = arg0.reserve_a + v0;
        let v2 = arg0.reserve_a * arg0.reserve_b / v1;
        let v3 = arg0.reserve_b - v2;
        assert!(v3 > arg2, 1);
        arg0.reserve_a = v1;
        0x2::coin::join<T0>(&mut arg0.coin_a, arg1);
        arg0.reserve_b = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0.coin_b, v3, arg3), 0x2::tx_context::sender(arg3));
    }

    entry fun swap_b_for_a<T0, T1>(arg0: &mut LiquidPool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T1>(0x2::coin::balance<T1>(&arg1));
        assert!(v0 > 0, 0);
        let v1 = arg0.reserve_b + v0;
        let v2 = arg0.reserve_a * arg0.reserve_b / v1;
        let v3 = arg0.reserve_a - v2;
        assert!(v3 > arg2, 1);
        arg0.reserve_a = v2;
        0x2::coin::join<T1>(&mut arg0.coin_b, arg1);
        arg0.reserve_b = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.coin_a, v3, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

