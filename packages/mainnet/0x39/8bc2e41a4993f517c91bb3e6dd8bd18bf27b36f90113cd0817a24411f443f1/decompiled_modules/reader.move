module 0x398bc2e41a4993f517c91bb3e6dd8bd18bf27b36f90113cd0817a24411f443f1::reader {
    struct WindowCursor has drop {
        score: 0x1::option::Option<u64>,
        terminal: bool,
        stalled: bool,
    }

    public fun begin_if<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: bool) : (WindowCursor, u128, vector<u128>, vector<u128>, vector<bool>, u64, u64, bool) {
        let v0 = if (arg4) {
            let v1 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::first_score_for_swap(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::tick_manager<T0, T1>(arg0), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg0), arg1);
            if (0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::is_some(&v1)) {
                0x1::option::some<u64>(0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::borrow(&v1))
            } else {
                0x1::option::none<u64>()
            }
        } else {
            0x1::option::none<u64>()
        };
        let v2 = WindowCursor{
            score    : v0,
            terminal : false,
            stalled  : false,
        };
        let v3 = &mut v2;
        let (v4, v5, v6, v7, v8, v9, v10) = continue_if<T0, T1>(arg0, arg1, v3, arg2, arg3, arg4);
        (v2, v4, v5, v6, v7, v8, v9, v10)
    }

    public fun continue_if<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: bool, arg2: &mut WindowCursor, arg3: u64, arg4: u64, arg5: bool) : (u128, vector<u128>, vector<u128>, vector<bool>, u64, u64, bool) {
        let v0 = if (!arg5) {
            true
        } else if (arg2.terminal) {
            true
        } else {
            arg2.stalled
        };
        if (v0) {
            return (0, vector[], vector[], vector[], 0, 0, arg2.terminal)
        };
        let v1 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::tick_manager<T0, T1>(arg0);
        let v2 = vector[];
        let v3 = vector[];
        let v4 = vector[];
        let v5 = 0;
        while (v5 < 0x1::u64::min(arg3, arg4) && 0x1::option::is_some<u64>(&arg2.score)) {
            let v6 = *0x1::option::borrow<u64>(&arg2.score);
            let (v7, v8) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::borrow_tick_for_swap(v1, v6, arg1);
            let v9 = v8;
            let v10 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::liquidity_net(v7);
            0x1::vector::push_back<u128>(&mut v2, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::sqrt_price(v7));
            0x1::vector::push_back<u128>(&mut v3, 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::abs_u128(v10));
            0x1::vector::push_back<bool>(&mut v4, 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::is_neg(v10));
            v5 = v5 + 1;
            let v11 = 0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::is_some(&v9) && 0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::borrow(&v9) == v6;
            arg2.stalled = v11;
            let v12 = if (0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::is_some(&v9)) {
                0x1::option::some<u64>(0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::borrow(&v9))
            } else {
                0x1::option::none<u64>()
            };
            arg2.score = v12;
            if (arg2.stalled) {
                break
            };
        };
        arg2.terminal = !0x1::option::is_some<u64>(&arg2.score);
        if (arg2.terminal) {
            let v13 = if (arg1) {
                0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::min_sqrt_price()
            } else {
                0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::max_sqrt_price()
            };
            if (0x1::vector::is_empty<u128>(&v2) || *0x1::vector::borrow<u128>(&v2, 0x1::vector::length<u128>(&v2) - 1) != v13) {
                0x1::vector::push_back<u128>(&mut v2, v13);
                0x1::vector::push_back<u128>(&mut v3, 0);
                0x1::vector::push_back<bool>(&mut v4, false);
            };
        };
        (0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::liquidity<T0, T1>(arg0), v2, v3, v4, v5, v5, arg2.terminal)
    }

    public fun current<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>) : (u128, u64, u64) {
        (0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg0), 1000000)
    }

    public fun economic_window_if<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: bool, arg4: u256) : (u128, vector<u128>, vector<u128>, vector<bool>) {
        window_impl<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun window_if<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: bool) : (u128, vector<u128>, vector<u128>, vector<bool>) {
        window_impl<T0, T1>(arg0, arg1, arg2, arg3, 0)
    }

    fun window_impl<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: bool, arg4: u256) : (u128, vector<u128>, vector<u128>, vector<bool>) {
        if (!arg3) {
            return (0, vector[], vector[], vector[])
        };
        assert!(arg2 > 0, 1);
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::tick_manager<T0, T1>(arg0);
        let v1 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::first_score_for_swap(v0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg0), arg1);
        let v2 = vector[];
        let v3 = vector[];
        let v4 = vector[];
        let v5 = 0;
        let v6 = 0;
        while (v5 < arg2 && 0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::is_some(&v1)) {
            let (v7, v8) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::borrow_tick_for_swap(v0, 0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::borrow(&v1), arg1);
            let v9 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::liquidity_net(v7);
            let v10 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::sqrt_price(v7);
            v6 = v10;
            0x1::vector::push_back<u128>(&mut v2, v10);
            0x1::vector::push_back<u128>(&mut v3, 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::abs_u128(v9));
            0x1::vector::push_back<bool>(&mut v4, 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::is_neg(v9));
            v1 = v8;
            v5 = v5 + 1;
            if (arg4 > 0) {
                let v11 = (v10 as u256) * (v10 as u256);
                if (arg1 && v11 <= arg4 || !arg1 && v11 >= arg4) {
                    break
                };
            };
        };
        let v12 = if (arg1) {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::min_sqrt_price()
        } else {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::max_sqrt_price()
        };
        if (!0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::is_some(&v1) && (v5 == 0 || v6 != v12)) {
            0x1::vector::push_back<u128>(&mut v2, v12);
            0x1::vector::push_back<u128>(&mut v3, 0);
            0x1::vector::push_back<bool>(&mut v4, false);
        };
        (0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::liquidity<T0, T1>(arg0), v2, v3, v4)
    }

    // decompiled from Move bytecode v7
}

