module 0xd6a1142950bb47cc602cd2159befd9d85881a389bd744f01dd7f1f78b8ac2ea2::task5 {
    struct PoolCoin<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
        pool_coin: 0x2::balance::Supply<PoolCoin<T0, T1>>,
    }

    public entry fun add_pool<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T0>(arg5);
        let v1 = 0x2::coin::zero<T1>(arg5);
        0x2::pay::join<T0>(&mut v0, arg1);
        0x2::pay::join<T1>(&mut v1, arg2);
        0x2::coin::put<T0>(&mut arg0.coin_a, 0x2::coin::split<T0>(&mut v0, arg3, arg5));
        0x2::coin::put<T1>(&mut arg0.coin_b, 0x2::coin::split<T1>(&mut v1, arg4, arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<PoolCoin<T0, T1>>>(0x2::coin::from_balance<PoolCoin<T0, T1>>(0x2::balance::increase_supply<PoolCoin<T0, T1>>(&mut arg0.pool_coin, arg3 + arg4), arg5), 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg5));
    }

    public entry fun create_pool<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolCoin<T0, T1>{dummy_field: false};
        let v1 = Pool<T0, T1>{
            id        : 0x2::object::new(arg0),
            coin_a    : 0x2::balance::zero<T0>(),
            coin_b    : 0x2::balance::zero<T1>(),
            pool_coin : 0x2::balance::create_supply<PoolCoin<T0, T1>>(v0),
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v1);
    }

    public entry fun swap_a_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T0>(arg3);
        0x2::pay::join<T0>(&mut v0, arg1);
        0x2::coin::put<T0>(&mut arg0.coin_a, 0x2::coin::split<T0>(&mut v0, arg2, arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.coin_b, arg2, arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_b_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T1>(arg3);
        0x2::pay::join<T1>(&mut v0, arg1);
        0x2::coin::put<T1>(&mut arg0.coin_b, 0x2::coin::split<T1>(&mut v0, arg2, arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.coin_b, arg2, arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

