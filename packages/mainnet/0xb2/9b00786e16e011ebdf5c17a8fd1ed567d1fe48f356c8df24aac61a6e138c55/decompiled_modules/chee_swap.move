module 0xb29b00786e16e011ebdf5c17a8fd1ed567d1fe48f356c8df24aac61a6e138c55::chee_swap {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
        x: u64,
        y: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        address: address,
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0 && v1 > 0, 3);
        0x2::balance::join<T0>(&mut arg0.coin_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.coin_b, 0x2::coin::into_balance<T1>(arg2));
        arg0.x = arg0.x + v0;
        arg0.y = arg0.y + v1;
    }

    public entry fun create_pool<T0, T1>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0, T1>{
            id     : 0x2::object::new(arg2),
            coin_a : 0x2::balance::zero<T0>(),
            coin_b : 0x2::balance::zero<T1>(),
            x      : arg0,
            y      : arg1,
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v0);
    }

    public entry fun destroy_pool<T0, T1>(arg0: &AdminCap, arg1: Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.address, 4);
        let Pool {
            id     : v0,
            coin_a : v1,
            coin_b : v2,
            x      : _,
            y      : _,
        } = arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg2), 0x2::tx_context::sender(arg2));
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id      : 0x2::object::new(arg0),
            address : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun swapA<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T1>(&arg1) >= arg2 && arg2 > 0, 2);
        0x2::balance::join<T1>(&mut arg0.coin_b, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg1, arg2, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a, 1000000 * arg2 * arg0.y / arg0.x), arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, 0x2::tx_context::sender(arg3));
    }

    public entry fun swapB<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg2 && arg2 > 0, 2);
        0x2::balance::join<T0>(&mut arg0.coin_a, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg2, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b, 1000000 * arg2 * arg0.y / arg0.x), arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

