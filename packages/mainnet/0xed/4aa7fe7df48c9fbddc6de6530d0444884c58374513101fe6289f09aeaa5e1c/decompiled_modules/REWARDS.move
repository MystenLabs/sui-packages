module 0xed4aa7fe7df48c9fbddc6de6530d0444884c58374513101fe6289f09aeaa5e1c::REWARDS {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coin_b_reserve: 0x2::balance::Balance<T0>,
        coin_c_reserve: 0x2::balance::Balance<T1>,
        treasury: address,
    }

    public entry fun add_liquidity_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 0);
        0x2::balance::join<T0>(&mut arg0.coin_b_reserve, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun add_liquidity_c<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T1>(&arg1) > 0, 0);
        0x2::balance::join<T1>(&mut arg0.coin_c_reserve, 0x2::coin::into_balance<T1>(arg1));
    }

    public entry fun claim_reward<T0, T1, T2>(arg0: &mut Pool<T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) > 0 && (arg2 > 0 || arg3 > 0), 0);
        if (arg2 > 0) {
            assert!(0x2::balance::value<T1>(&arg0.coin_b_reserve) >= arg2, 1);
        };
        if (arg3 > 0) {
            assert!(0x2::balance::value<T2>(&arg0.coin_c_reserve) >= arg3, 1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.treasury);
        if (arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b_reserve, arg2), arg4), 0x2::tx_context::sender(arg4));
        };
        if (arg3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.coin_c_reserve, arg3), arg4), 0x2::tx_context::sender(arg4));
        };
    }

    public entry fun create_pool<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) > 0 && 0x2::coin::value<T1>(&arg1) > 0, 0);
        let v0 = Pool<T0, T1>{
            id             : 0x2::object::new(arg3),
            coin_b_reserve : 0x2::coin::into_balance<T0>(arg0),
            coin_c_reserve : 0x2::coin::into_balance<T1>(arg1),
            treasury       : arg2,
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v0);
    }

    public fun get_pool_liquidity<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin_b_reserve), 0x2::balance::value<T1>(&arg0.coin_c_reserve))
    }

    // decompiled from Move bytecode v6
}

