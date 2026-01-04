module 0x84b03aa9cf25b028549c4c14937ba5834b19f22b55fc0e5872297af0c3c9788b::REWARDS {
    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        coin_c_reserve: 0x2::balance::Balance<T0>,
        treasury: address,
    }

    public entry fun add_liquidity_c<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 0);
        0x2::balance::join<T0>(&mut arg0.coin_c_reserve, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun claim_reward<T0, T1>(arg0: &mut Pool<T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) > 0 && arg2 > 0, 0);
        assert!(0x2::balance::value<T1>(&arg0.coin_c_reserve) >= arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_c_reserve, arg2), arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.treasury);
    }

    public entry fun create_pool<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) > 0, 0);
        let v0 = Pool<T0>{
            id             : 0x2::object::new(arg2),
            coin_c_reserve : 0x2::coin::into_balance<T0>(arg0),
            treasury       : arg1,
        };
        0x2::transfer::share_object<Pool<T0>>(v0);
    }

    public fun get_pool_liquidity<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.coin_c_reserve)
    }

    // decompiled from Move bytecode v6
}

