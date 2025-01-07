module 0xccbcf37a1f600d6450741bd045ebcc00d47095cbde55541e8e79712734cceddd::qpb8023 {
    struct PoolInfo<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        token1: 0x2::balance::Balance<T0>,
        token2: 0x2::balance::Balance<T1>,
    }

    public entry fun AtoB<T0, T1>(arg0: &mut PoolInfo<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 0);
        0x2::balance::join<T0>(&mut arg0.token1, 0x2::coin::into_balance<T0>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.token2, 0x2::coin::value<T0>(&arg1)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun BtoA<T0, T1>(arg0: &mut PoolInfo<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T1>(&arg1) > 0, 0);
        0x2::balance::join<T1>(&mut arg0.token2, 0x2::coin::into_balance<T1>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token1, 0x2::coin::value<T1>(&arg1)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun add_liquty<T0, T1>(arg0: &mut PoolInfo<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.token1, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.token2, 0x2::coin::into_balance<T1>(arg2));
    }

    public entry fun init_pool<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolInfo<T0, T1>{
            id     : 0x2::object::new(arg2),
            token1 : 0x2::coin::into_balance<T0>(arg0),
            token2 : 0x2::coin::into_balance<T1>(arg1),
        };
        0x2::transfer::share_object<PoolInfo<T0, T1>>(v0);
    }

    public entry fun remove_liquty<T0, T1>(arg0: &mut PoolInfo<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token1, arg1), arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.token2, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

