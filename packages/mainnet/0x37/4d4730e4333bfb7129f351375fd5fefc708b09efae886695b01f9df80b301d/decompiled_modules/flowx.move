module 0xbe0365cd0d19561da05ab5cc70d6b974d8b43e0163e6898353afd8f6efc45e81::flowx {
    public fun swap<T0, T1, T2, T3>(arg0: &mut 0xbe0365cd0d19561da05ab5cc70d6b974d8b43e0163e6898353afd8f6efc45e81::checkpoint::Payload<T2, T3>, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg2: bool, arg3: bool, arg4: u128, arg5: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0x2::balance::zero<T1>();
        if (arg2) {
            0x2::balance::join<T0>(&mut v0, 0xbe0365cd0d19561da05ab5cc70d6b974d8b43e0163e6898353afd8f6efc45e81::checkpoint::take_next<T2, T3, T0>(arg0));
        } else {
            0x2::balance::join<T1>(&mut v1, 0xbe0365cd0d19561da05ab5cc70d6b974d8b43e0163e6898353afd8f6efc45e81::checkpoint::take_next<T2, T3, T1>(arg0));
        };
        let v2 = if (arg2) {
            0x2::balance::value<T0>(&v0)
        } else {
            0x2::balance::value<T1>(&v1)
        };
        let (v3, v4, v5) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(arg1, arg2, arg3, v2, arg4, arg5, arg6, arg7);
        if (arg2) {
            0xbe0365cd0d19561da05ab5cc70d6b974d8b43e0163e6898353afd8f6efc45e81::checkpoint::place_next<T2, T3, T1>(arg0, v4);
            0x2::balance::destroy_zero<T0>(v3);
        } else {
            0xbe0365cd0d19561da05ab5cc70d6b974d8b43e0163e6898353afd8f6efc45e81::checkpoint::place_next<T2, T3, T0>(arg0, v3);
            0x2::balance::destroy_zero<T1>(v4);
        };
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(arg1, v5, v0, v1, arg5, arg7);
    }

    public fun borrow_swap<T0, T1, T2, T3>(arg0: &mut 0xbe0365cd0d19561da05ab5cc70d6b974d8b43e0163e6898353afd8f6efc45e81::checkpoint::Payload<T2, T3>, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: u64, arg3: bool, arg4: bool, arg5: u128, arg6: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg1, arg2);
        swap<T0, T1, T2, T3>(arg0, v0, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    // decompiled from Move bytecode v6
}

