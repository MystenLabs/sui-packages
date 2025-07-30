module 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::swap_router {
    fun get_sqrt_price_limit(arg0: u128, arg1: bool) : u128 {
        if (arg0 == 0) {
            if (arg1) {
                0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::tick_math::min_sqrt_price() + 1
            } else {
                0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::tick_math::max_sqrt_price() - 1
            }
        } else {
            arg0
        }
    }

    public fun swap_exact_input<T0, T1>(arg0: &mut 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool_manager::PoolRegistry, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u128, arg5: u64, arg6: &0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::utils::check_deadline(arg7, arg5);
        let v0 = if (0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::utils::is_ordered<T0, T1>()) {
            let v1 = 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool_manager::borrow_mut_pool<T0, T1>(arg0, arg1);
            swap_exact_x_to_y<T0, T1>(v1, arg2, arg4, arg6, arg7, arg8)
        } else {
            let v2 = 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool_manager::borrow_mut_pool<T1, T0>(arg0, arg1);
            swap_exact_y_to_x<T1, T0>(v2, arg2, arg4, arg6, arg7, arg8)
        };
        let v3 = v0;
        if (0x2::balance::value<T1>(&v3) < arg3) {
            abort 1
        };
        0x2::coin::from_balance<T1>(v3, arg8)
    }

    public fun swap_exact_output<T0, T1>(arg0: &mut 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool_manager::PoolRegistry, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u128, arg5: u64, arg6: &0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::utils::check_deadline(arg7, arg5);
        let v0 = if (0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::utils::is_ordered<T0, T1>()) {
            let v1 = 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool_manager::borrow_mut_pool<T0, T1>(arg0, arg1);
            swap_x_to_exact_y<T0, T1>(v1, arg2, arg3, arg4, arg6, arg7, arg8)
        } else {
            let v2 = 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool_manager::borrow_mut_pool<T1, T0>(arg0, arg1);
            swap_y_to_exact_x<T1, T0>(v2, arg2, arg3, arg4, arg6, arg7, arg8)
        };
        0x2::coin::from_balance<T1>(v0, arg8)
    }

    public fun swap_exact_x_to_y<T0, T1>(arg0: &mut 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u128, arg3: &0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::swap<T0, T1>(arg0, true, true, 0x2::coin::value<T0>(&arg1), get_sqrt_price_limit(arg2, true), arg3, arg4, arg5);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, _) = 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::swap_receipt_debts(&v3);
        0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::pay<T0, T1>(arg0, v3, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(&mut arg1), v4), 0x2::balance::zero<T1>(), arg3, arg5);
        0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::utils::refund<T0>(arg1, 0x2::tx_context::sender(arg5));
        v1
    }

    public fun swap_exact_y_to_x<T0, T1>(arg0: &mut 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u128, arg3: &0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::swap<T0, T1>(arg0, false, true, 0x2::coin::value<T1>(&arg1), get_sqrt_price_limit(arg2, false), arg3, arg4, arg5);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (_, v5) = 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::swap_receipt_debts(&v3);
        0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::pay<T0, T1>(arg0, v3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(&mut arg1), v5), arg3, arg5);
        0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::utils::refund<T1>(arg1, 0x2::tx_context::sender(arg5));
        v0
    }

    public fun swap_x_to_exact_y<T0, T1>(arg0: &mut 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u128, arg4: &0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::swap<T0, T1>(arg0, true, false, arg2, get_sqrt_price_limit(arg3, true), arg4, arg5, arg6);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (v4, _) = 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::swap_receipt_debts(&v3);
        if (v4 > 0x2::coin::value<T0>(&arg1)) {
            abort 2
        };
        0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::pay<T0, T1>(arg0, v3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v4, arg6)), 0x2::balance::zero<T1>(), arg4, arg6);
        0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::utils::refund<T0>(arg1, 0x2::tx_context::sender(arg6));
        v1
    }

    public fun swap_y_to_exact_x<T0, T1>(arg0: &mut 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u128, arg4: &0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::swap<T0, T1>(arg0, false, false, arg2, get_sqrt_price_limit(arg3, false), arg4, arg5, arg6);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (_, v5) = 0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::swap_receipt_debts(&v3);
        if (v5 > 0x2::coin::value<T1>(&arg1)) {
            abort 2
        };
        0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::pool::pay<T0, T1>(arg0, v3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg1, v5, arg6)), arg4, arg6);
        0x2205873dfb42d9454a54814f5b9ea4a76e73718ed6453802e7c2f6bc8aa9ea90::utils::refund<T1>(arg1, 0x2::tx_context::sender(arg6));
        v0
    }

    // decompiled from Move bytecode v6
}

