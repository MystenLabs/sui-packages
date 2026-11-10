module 0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::vq_x {
    fun o<T0, T1>(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : u64 {
        let v0 = if (arg1) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let v1 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, T1>(arg0);
        if (arg1 && v0 >= v1 || !arg1 && v0 <= v1) {
            return 0
        };
        let v2 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::borrow_ticks<T0, T1>(arg0);
        let v3 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::borrow_tick_bitmap<T0, T1>(arg0);
        let v4 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::tick_index_current<T0, T1>(arg0);
        let v5 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::liquidity<T0, T1>(arg0);
        let v6 = arg2;
        let v7 = 0;
        while (v6 != 0 && v1 != v0) {
            let v8 = v1;
            let (v9, v10) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_bitmap::next_initialized_tick_within_one_word(v3, v4, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::tick_spacing<T0, T1>(arg0), arg1);
            let v11 = v9;
            if (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::lt(v9, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_tick())) {
                v11 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::min_tick();
            } else if (0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::gt(v9, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_tick())) {
                v11 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::max_tick();
            };
            let v12 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::get_sqrt_price_at_tick(v11);
            let v13 = if (arg1) {
                if (v12 > v0) {
                    v12
                } else {
                    v0
                }
            } else if (v12 < v0) {
                v12
            } else {
                v0
            };
            let (v14, v15, v16, v17) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_math::compute_swap_step(v1, v13, v5, v6, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_fee_rate<T0, T1>(arg0), true);
            v1 = v14;
            v6 = v6 - v15 + v17;
            v7 = v7 + v16;
            if (v14 == v12) {
                if (v10) {
                    let v18 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick::get_liquidity_net(v2, v11);
                    let v19 = v18;
                    if (arg1) {
                        v19 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i128::neg(v18);
                    };
                    v5 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::liquidity_math::add_delta(v5, v19);
                };
                let v20 = if (arg1) {
                    0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::sub(v11, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::from(1))
                } else {
                    v11
                };
                v4 = v20;
                continue
            };
            if (v14 != v8) {
                v4 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::tick_math::get_tick_at_sqrt_price(v14);
            };
        };
        if (v6 != 0) {
            0
        } else {
            v7
        }
    }

    fun v(arg0: vector<u8>) : bool {
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_address(&mut v0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 185);
        0x2::bcs::peel_u64(&mut v0) == 6
    }

    public fun x<T0, T1>(arg0: &mut 0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::Ht, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: 0x2::object::ID, arg3: u64, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: bool) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_pool<T0, T1>(arg1, arg3);
        assert!(0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>>(v0) == arg2, 184);
        let v1 = if (v(0x2::bcs::to_bytes<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned>(arg4))) {
            if (!0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::is_paused(arg4)) {
                !0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::is_locked<T0, T1>(v0)
            } else {
                false
            }
        } else {
            false
        };
        let v2 = 0;
        while (v2 < 0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::cn(arg0)) {
            let v3 = 0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::ra(arg0, v2);
            if (v3 > 0) {
                let v4 = if (v1) {
                    o<T0, T1>(v0, arg5, v3)
                } else {
                    0
                };
                0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::sr(arg0, v2, v4);
            };
            v2 = v2 + 1;
        };
        0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::np(arg0, 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>>(v0), arg5);
    }

    // decompiled from Move bytecode v7
}

