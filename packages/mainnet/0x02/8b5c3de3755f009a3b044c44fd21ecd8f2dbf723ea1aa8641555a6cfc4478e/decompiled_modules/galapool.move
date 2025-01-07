module 0x28b5c3de3755f009a3b044c44fd21ecd8f2dbf723ea1aa8641555a6cfc4478e::galapool {
    struct LPCoin<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coin_x: 0x2::balance::Balance<T0>,
        coin_y: 0x2::balance::Balance<T1>,
        lp_coin: 0x2::balance::Supply<LPCoin<T0, T1>>,
    }

    public fun add_pool<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LPCoin<T0, T1>> {
        0x2::coin::put<T0>(&mut arg0.coin_x, arg1);
        0x2::coin::put<T1>(&mut arg0.coin_y, arg2);
        0x2::coin::from_balance<LPCoin<T0, T1>>(0x2::balance::increase_supply<LPCoin<T0, T1>>(&mut arg0.lp_coin, 0x2::coin::value<T0>(&arg1) + 0x2::coin::value<T1>(&arg2)), arg3)
    }

    public fun create_pool<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LPCoin<T0, T1>{dummy_field: false};
        let v1 = Pool<T0, T1>{
            id      : 0x2::object::new(arg0),
            coin_x  : 0x2::balance::zero<T0>(),
            coin_y  : 0x2::balance::zero<T1>(),
            lp_coin : 0x2::balance::create_supply<LPCoin<T0, T1>>(v0),
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v1);
    }

    public fun remove_pool<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<LPCoin<T0, T1>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x2::balance::decrease_supply<LPCoin<T0, T1>>(&mut arg0.lp_coin, 0x2::coin::into_balance<LPCoin<T0, T1>>(0x2::coin::split<LPCoin<T0, T1>>(arg1, arg2 + arg3, arg4)));
        (0x2::coin::take<T0>(&mut arg0.coin_x, arg2, arg4), 0x2::coin::take<T1>(&mut arg0.coin_y, arg3, arg4))
    }

    public fun swap_x_to_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::put<T0>(&mut arg0.coin_x, arg1);
        0x2::coin::take<T1>(&mut arg0.coin_y, 0x2::coin::value<T0>(&arg1), arg2)
    }

    public fun swap_y_to_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::put<T1>(&mut arg0.coin_y, arg1);
        0x2::coin::take<T0>(&mut arg0.coin_x, 0x2::coin::value<T1>(&arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

