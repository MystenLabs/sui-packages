module 0x5f3ef2a4e8bcf39cedfc4556798af48aa358941bbd03cbbb9f09449789f57c03::momentum {
    fun check_gate(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version) {
        assert!(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::value_major(arg0) == 1 && 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::value_minor(arg0) == 6, 3);
    }

    public fun flash_x2y<T0, T1>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt) {
        check_gate(arg2);
        let v0 = 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::open_loan<T0>(arg0);
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, true, true, v0, limit<T0, T1>(arg1, true), arg3, arg2, arg4);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        let (v6, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        assert!(v6 == v0, 2);
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_leg<T0>(arg0, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1), true, 0x2::balance::value<T1>(&v5));
        (v5, v4)
    }

    public fun flash_y2x<T0, T1>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T1>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt) {
        check_gate(arg2);
        let v0 = 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::open_loan<T1>(arg0);
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, false, true, v0, limit<T0, T1>(arg1, false), arg3, arg2, arg4);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T1>(v2);
        let (_, v7) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        assert!(v7 == v0, 2);
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_leg<T1>(arg0, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1), false, 0x2::balance::value<T0>(&v5));
        (v5, v4)
    }

    fun limit<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool) : u128 {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0);
        if (arg1) {
            0x1::u128::max(v0 - v0 / 9, 4295048016)
        } else {
            0x1::u128::min(v0 + v0 / 8, 79226673515401279992447579055)
        }
    }

    public fun quote<T0, T1, T2>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: bool) {
        check_gate(arg2);
        let v0 = vector[];
        let v1 = 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::quote_inputs<T0>(arg0);
        0x1::vector::reverse<u64>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v1)) {
            0x1::vector::push_back<u64>(&mut v0, simulate<T1, T2>(arg1, limit<T1, T2>(arg1, arg3), 0x1::vector::pop_back<u64>(&mut v1), arg3));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u64>(v1);
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_quote<T0>(arg0, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>>(arg1), arg3, v0, vector[], vector[]);
    }

    public fun repay_x2y<T0, T1>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: 0x2::balance::Balance<T0>, arg4: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        check_gate(arg2);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, arg4, 0x2::balance::split<T0>(&mut arg3, 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::close_loan<T0>(arg0, &mut arg3)), 0x2::balance::zero<T1>(), arg2, arg5);
        arg3
    }

    public fun repay_y2x<T0, T1>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T1>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: 0x2::balance::Balance<T1>, arg4: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        check_gate(arg2);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, arg4, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::close_loan<T1>(arg0, &mut arg3)), arg2, arg5);
        arg3
    }

    fun simulate<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u128, arg2: u64, arg3: bool) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg0, arg3, true, arg1, arg2);
        if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_specified(&v0) != 0) {
            return 0
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v0)
    }

    public fun swap_x2y<T0, T1, T2>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        check_gate(arg2);
        let v0 = 0x2::balance::value<T1>(&arg4);
        assert!(v0 > 0, 1);
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T1, T2>(arg1, true, true, v0, limit<T1, T2>(arg1, true), arg3, arg2, arg5);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (v6, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T1, T2>(arg1, v4, 0x2::balance::split<T1>(&mut arg4, v6), 0x2::balance::zero<T2>(), arg2, arg5);
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_leg<T0>(arg0, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>>(arg1), true, 0x2::balance::value<T2>(&v5));
        (v5, arg4)
    }

    public fun swap_y2x<T0, T1, T2>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<T2>, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        check_gate(arg2);
        let v0 = 0x2::balance::value<T2>(&arg4);
        assert!(v0 > 0, 1);
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T1, T2>(arg1, false, true, v0, limit<T1, T2>(arg1, false), arg3, arg2, arg5);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T2>(v2);
        let (_, v7) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T1, T2>(arg1, v4, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut arg4, v7), arg2, arg5);
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_leg<T0>(arg0, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>>(arg1), false, 0x2::balance::value<T1>(&v5));
        (v5, arg4)
    }

    // decompiled from Move bytecode v7
}

