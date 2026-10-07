module 0x2023b05ab449734a164eada712f3a62856862e79dd4524f9e24f60ac77b45554::dipcoin {
    fun check_gate(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global) {
        let v0 = 0x2::bcs::new(0x2::bcs::to_bytes<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global>(arg0));
        0x2::bcs::peel_address(&mut v0);
        0x2::bcs::peel_bool(&mut v0);
        0x2::bcs::peel_bool(&mut v0);
        0x2::bcs::peel_address(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_vec_address(&mut v0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 1);
        assert!(0x2::bcs::peel_u64(&mut v0) == 1, 2);
    }

    public fun quote<T0, T1, T2>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T1, T2>, arg2: bool) {
        let (v0, v1, v2) = state<T1, T2>(arg1);
        let (v3, v4) = if (arg2) {
            (v0, v1)
        } else {
            (v1, v0)
        };
        let v5 = vector[];
        let v6 = 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::quote_inputs<T0>(arg0);
        0x1::vector::reverse<u64>(&mut v6);
        let v7 = 0;
        while (v7 < 0x1::vector::length<u64>(&v6)) {
            let v8 = 0x1::vector::pop_back<u64>(&mut v6);
            let v9 = if (v8 == 0) {
                true
            } else if (v3 == 0) {
                true
            } else {
                v4 == 0
            };
            let v10 = if (v9) {
                0
            } else {
                0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::math::get_amount_out(v2, v8, v3, v4)
            };
            0x1::vector::push_back<u64>(&mut v5, v10);
            v7 = v7 + 1;
        };
        0x1::vector::destroy_empty<u64>(v6);
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_quote<T0>(arg0, 0x2::object::id<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T1, T2>>(arg1), arg2, v5, vector[], vector[]);
    }

    fun state<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>) : (u64, u64, u64) {
        let v0 = 0x2::bcs::new(0x2::bcs::to_bytes<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>>(arg0));
        0x2::bcs::peel_address(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 1);
        (0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun swap_x2y<T0, T1, T2>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T1, T2>, arg2: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        check_gate(arg2);
        let v0 = 0x2::coin::into_balance<T2>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::router::swap_exact_x_to_y_with_return<T1, T2>(arg2, arg1, 0x2::coin::from_balance<T1>(arg3, arg4), 0, arg4));
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_leg<T0>(arg0, 0x2::object::id<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T1, T2>>(arg1), true, 0x2::balance::value<T2>(&v0));
        (v0, 0x2::balance::zero<T1>())
    }

    public fun swap_y2x<T0, T1, T2>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T1, T2>, arg2: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg3: 0x2::balance::Balance<T2>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        check_gate(arg2);
        let v0 = 0x2::coin::into_balance<T1>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::router::swap_exact_y_to_x_with_return<T1, T2>(arg2, arg1, 0x2::coin::from_balance<T2>(arg3, arg4), 0, arg4));
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_leg<T0>(arg0, 0x2::object::id<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T1, T2>>(arg1), false, 0x2::balance::value<T1>(&v0));
        (v0, 0x2::balance::zero<T2>())
    }

    // decompiled from Move bytecode v7
}

