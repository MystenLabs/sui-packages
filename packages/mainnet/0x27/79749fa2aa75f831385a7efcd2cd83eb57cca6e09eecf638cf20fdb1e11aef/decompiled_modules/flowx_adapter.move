module 0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::flowx_adapter {
    public fun swap_x_to_y<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        swap_x_to_y_with_limit<T0, T1>(arg0, arg1, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_sqrt_price() + 1, arg2, arg3, arg4)
    }

    public fun swap_x_to_y_with_limit<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg2: u128, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let (v1, v2, v3) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(arg1, true, true, v0, arg2, arg3, arg4, arg5);
        let v4 = v3;
        let (v5, _) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v4);
        assert!(v5 == v0, 0);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(arg1, v4, 0x2::coin::into_balance<T0>(arg0), 0x2::balance::zero<T1>(), arg3, arg5);
        0x2::balance::destroy_zero<T0>(v1);
        0x2::coin::from_balance<T1>(v2, arg5)
    }

    public fun swap_y_to_x<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        swap_y_to_x_with_limit<T0, T1>(arg0, arg1, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_sqrt_price() - 1, arg2, arg3, arg4)
    }

    public fun swap_y_to_x_with_limit<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg2: u128, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg0);
        let (v1, v2, v3) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(arg1, false, true, v0, arg2, arg3, arg4, arg5);
        let v4 = v3;
        let (_, v6) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v4);
        assert!(v6 == v0, 0);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(arg1, v4, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg0), arg3, arg5);
        0x2::balance::destroy_zero<T1>(v2);
        0x2::coin::from_balance<T0>(v1, arg5)
    }

    // decompiled from Move bytecode v6
}

