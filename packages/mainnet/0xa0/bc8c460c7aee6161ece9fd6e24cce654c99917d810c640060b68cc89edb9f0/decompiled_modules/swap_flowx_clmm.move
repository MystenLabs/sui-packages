module 0xa0bc8c460c7aee6161ece9fd6e24cce654c99917d810c640060b68cc89edb9f0::swap_flowx_clmm {
    public fun swap<T0, T1, T2, T3>(arg0: 0x1::option::Option<0x2::coin::Coin<T0>>, arg1: 0x1::option::Option<0x2::coin::Coin<T1>>, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &0xa0bc8c460c7aee6161ece9fd6e24cce654c99917d810c640060b68cc89edb9f0::swap_transaction::SwapTransaction<T2, T3>, arg6: &0xa0bc8c460c7aee6161ece9fd6e24cce654c99917d810c640060b68cc89edb9f0::state::State, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0xa0bc8c460c7aee6161ece9fd6e24cce654c99917d810c640060b68cc89edb9f0::utils::parse_amount_and_direction<T0, T1>(&arg0, &arg1);
        let v2 = if (v1) {
            0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_sqrt_price()
        } else {
            0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_sqrt_price()
        };
        let (v3, v4, v5) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(arg2, v1, true, v0, v2, arg3, arg4, arg7);
        let v6 = v4;
        let v7 = v3;
        let v8 = if (v1) {
            0x2::coin::into_balance<T0>(0x1::option::extract<0x2::coin::Coin<T0>>(&mut arg0))
        } else {
            0x2::balance::zero<T0>()
        };
        let v9 = if (v1) {
            0x2::balance::zero<T1>()
        } else {
            0x2::coin::into_balance<T1>(0x1::option::extract<0x2::coin::Coin<T1>>(&mut arg1))
        };
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(arg2, v5, v8, v9, arg3, arg7);
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg0);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg1);
        let v10 = if (v1) {
            0x2::balance::value<T1>(&v6)
        } else {
            0x2::balance::value<T0>(&v7)
        };
        let v11 = 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>>(arg2);
        0xa0bc8c460c7aee6161ece9fd6e24cce654c99917d810c640060b68cc89edb9f0::swap_event::emit_common_swap<T0, T1>(0xa0bc8c460c7aee6161ece9fd6e24cce654c99917d810c640060b68cc89edb9f0::consts::DEX_FLOWX_CLMM(), 0x2::object::id_to_address(&v11), v1, v0, v10, true);
        (0x2::coin::from_balance<T0>(v7, arg7), 0x2::coin::from_balance<T1>(v6, arg7))
    }

    public fun swap_a2b<T0, T1, T2, T3>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: &0xa0bc8c460c7aee6161ece9fd6e24cce654c99917d810c640060b68cc89edb9f0::swap_transaction::SwapTransaction<T2, T3>, arg5: &0xa0bc8c460c7aee6161ece9fd6e24cce654c99917d810c640060b68cc89edb9f0::state::State, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = swap<T0, T1, T2, T3>(0x1::option::some<0x2::coin::Coin<T0>>(arg0), 0x1::option::none<0x2::coin::Coin<T1>>(), arg1, arg2, arg3, arg4, arg5, arg6);
        0xa0bc8c460c7aee6161ece9fd6e24cce654c99917d810c640060b68cc89edb9f0::utils::transfer_or_destroy<T0>(v0, arg6);
        v1
    }

    public fun swap_b2a<T0, T1, T2, T3>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: &0xa0bc8c460c7aee6161ece9fd6e24cce654c99917d810c640060b68cc89edb9f0::swap_transaction::SwapTransaction<T2, T3>, arg5: &0xa0bc8c460c7aee6161ece9fd6e24cce654c99917d810c640060b68cc89edb9f0::state::State, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = swap<T0, T1, T2, T3>(0x1::option::none<0x2::coin::Coin<T0>>(), 0x1::option::some<0x2::coin::Coin<T1>>(arg0), arg1, arg2, arg3, arg4, arg5, arg6);
        0xa0bc8c460c7aee6161ece9fd6e24cce654c99917d810c640060b68cc89edb9f0::utils::transfer_or_destroy<T1>(v1, arg6);
        v0
    }

    // decompiled from Move bytecode v6
}

