module 0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::flowx {
    fun swap_x_to_y_via_registry<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: 0x2::balance::Balance<T0>, arg3: u128, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg0, arg1);
        let (v1, v2, v3) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(v0, true, true, 0x2::balance::value<T0>(&arg2), arg3, arg4, arg5, arg6);
        let v4 = v3;
        0x2::balance::join<T0>(&mut arg2, v1);
        let (v5, _) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v4);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(v0, v4, 0x2::balance::split<T0>(&mut arg2, v5), 0x2::balance::zero<T1>(), arg4, arg6);
        (v2, arg2)
    }

    fun swap_y_to_x_via_registry<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: 0x2::balance::Balance<T1>, arg3: u128, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg0, arg1);
        let (v1, v2, v3) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(v0, false, true, 0x2::balance::value<T1>(&arg2), arg3, arg4, arg5, arg6);
        let v4 = v3;
        0x2::balance::join<T1>(&mut arg2, v2);
        let (_, v6) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v4);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(v0, v4, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, v6), arg4, arg6);
        (v1, arg2)
    }

    public fun sxr<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: 0x2::balance::Balance<T0>, arg3: u128, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1) = swap_x_to_y_via_registry<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::tools::da<T0>(v1, arg6);
        v0
    }

    public fun sxv<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: 0x2::balance::Balance<T0>, arg3: u128, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext, arg7: &mut 0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::wallet::Vault<T0>) : 0x2::balance::Balance<T1> {
        let (v0, v1) = swap_x_to_y_via_registry<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::wallet::destroy_or_deposit_balance<T0>(arg7, v1);
        v0
    }

    public fun syr<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: 0x2::balance::Balance<T1>, arg3: u128, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1) = swap_y_to_x_via_registry<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::tools::da<T1>(v1, arg6);
        v0
    }

    public fun syv<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: 0x2::balance::Balance<T1>, arg3: u128, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext, arg7: &mut 0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::wallet::Vault<T1>) : 0x2::balance::Balance<T0> {
        let (v0, v1) = swap_y_to_x_via_registry<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::wallet::destroy_or_deposit_balance<T1>(arg7, v1);
        v0
    }

    // decompiled from Move bytecode v7
}

