module 0xa1452d543e0125d87fed8f947bb005659166f6800f63f10c76edca3f0b968009::swap_flowx_clmm {
    public fun swap<T0, T1, T2, T3>(arg0: 0x1::option::Option<0x2::coin::Coin<T0>>, arg1: 0x1::option::Option<0x2::coin::Coin<T1>>, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: u64, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0xa1452d543e0125d87fed8f947bb005659166f6800f63f10c76edca3f0b968009::swap_transaction::SwapTransaction<T2, T3>, arg7: &0xa1452d543e0125d87fed8f947bb005659166f6800f63f10c76edca3f0b968009::state::State, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0xa1452d543e0125d87fed8f947bb005659166f6800f63f10c76edca3f0b968009::utils::parse_amount_and_direction<T0, T1>(&arg0, &arg1);
        let v2 = if (v1) {
            0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_sqrt_price() + 1
        } else {
            0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_sqrt_price() - 1
        };
        let v3 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg2, arg3);
        let (v4, v5, v6) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(v3, v1, true, v0, v2, arg4, arg5, arg8);
        let v7 = v5;
        let v8 = v4;
        let v9 = if (v1) {
            0x2::coin::into_balance<T0>(0x1::option::extract<0x2::coin::Coin<T0>>(&mut arg0))
        } else {
            0x2::balance::zero<T0>()
        };
        let v10 = if (v1) {
            0x2::balance::zero<T1>()
        } else {
            0x2::coin::into_balance<T1>(0x1::option::extract<0x2::coin::Coin<T1>>(&mut arg1))
        };
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(v3, v6, v9, v10, arg4, arg8);
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg0);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg1);
        let v11 = if (v1) {
            0x2::balance::value<T1>(&v7)
        } else {
            0x2::balance::value<T0>(&v8)
        };
        let v12 = 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>>(v3);
        0xa1452d543e0125d87fed8f947bb005659166f6800f63f10c76edca3f0b968009::swap_event::emit_common_swap<T0, T1>(0xa1452d543e0125d87fed8f947bb005659166f6800f63f10c76edca3f0b968009::consts::DEX_FLOWX_CLMM(), 0x2::object::id_to_address(&v12), v1, v0, v11, true);
        (0x2::coin::from_balance<T0>(v8, arg8), 0x2::coin::from_balance<T1>(v7, arg8))
    }

    public fun swap_a2b<T0, T1, T2, T3>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: u64, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &0xa1452d543e0125d87fed8f947bb005659166f6800f63f10c76edca3f0b968009::swap_transaction::SwapTransaction<T2, T3>, arg6: &0xa1452d543e0125d87fed8f947bb005659166f6800f63f10c76edca3f0b968009::state::State, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = swap<T0, T1, T2, T3>(0x1::option::some<0x2::coin::Coin<T0>>(arg0), 0x1::option::none<0x2::coin::Coin<T1>>(), arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0xa1452d543e0125d87fed8f947bb005659166f6800f63f10c76edca3f0b968009::utils::transfer_or_destroy<T0>(v0, arg7);
        v1
    }

    public fun swap_b2a<T0, T1, T2, T3>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: u64, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &0xa1452d543e0125d87fed8f947bb005659166f6800f63f10c76edca3f0b968009::swap_transaction::SwapTransaction<T2, T3>, arg6: &0xa1452d543e0125d87fed8f947bb005659166f6800f63f10c76edca3f0b968009::state::State, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = swap<T0, T1, T2, T3>(0x1::option::none<0x2::coin::Coin<T0>>(), 0x1::option::some<0x2::coin::Coin<T1>>(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0xa1452d543e0125d87fed8f947bb005659166f6800f63f10c76edca3f0b968009::utils::transfer_or_destroy<T1>(v1, arg7);
        v0
    }

    // decompiled from Move bytecode v6
}

