module 0x35507336a0e70fe3bb7ae87d089e66b265b2ed1eab1a4daa7ffe8e1bb420b21a::pool {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        balanceA: 0x2::balance::Balance<T0>,
        balanceB: 0x2::balance::Balance<T1>,
    }

    public fun swap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x1::option::Option<0x2::coin::Coin<T0>>, arg2: 0x1::option::Option<0x2::coin::Coin<T1>>, arg3: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::coin::Coin<T0>>, 0x1::option::Option<0x2::coin::Coin<T1>>) {
        assert!(!0x1::option::is_some<0x2::coin::Coin<T0>>(&arg1) || !0x1::option::is_some<0x2::coin::Coin<T1>>(&arg2), 1);
        assert!(0x1::option::is_some<0x2::coin::Coin<T0>>(&arg1) || 0x1::option::is_some<0x2::coin::Coin<T1>>(&arg2), 2);
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg1)) {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg2);
            let v2 = &mut arg0.balanceA;
            let v3 = &mut arg0.balanceB;
            (0x1::option::none<0x2::coin::Coin<T0>>(), 0x1::option::some<0x2::coin::Coin<T1>>(swap_coin<T0, T1>(v2, v3, 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg1), arg3)))
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg1);
            let v4 = &mut arg0.balanceB;
            let v5 = &mut arg0.balanceA;
            (0x1::option::some<0x2::coin::Coin<T0>>(swap_coin<T1, T0>(v4, v5, 0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg2), arg3)), 0x1::option::none<0x2::coin::Coin<T1>>())
        }
    }

    public fun new<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0, T1>{
            id       : 0x2::object::new(arg0),
            balanceA : 0x2::balance::zero<T0>(),
            balanceB : 0x2::balance::zero<T1>(),
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v0);
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>) {
        0x2::balance::join<T0>(&mut arg0.balanceA, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.balanceB, 0x2::coin::into_balance<T1>(arg2));
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balanceA, arg1), arg3), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balanceB, arg2), arg3))
    }

    fun swap_coin<T0, T1>(arg0: &mut 0x2::balance::Balance<T0>, arg1: &mut 0x2::balance::Balance<T1>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::balance::join<T0>(arg0, 0x2::coin::into_balance<T0>(arg2));
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(arg1, 0x2::coin::value<T0>(&arg2)), arg3)
    }

    // decompiled from Move bytecode v6
}

