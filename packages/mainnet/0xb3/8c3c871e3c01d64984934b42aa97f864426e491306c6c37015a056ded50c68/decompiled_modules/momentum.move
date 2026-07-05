module 0xb38c3c871e3c01d64984934b42aa97f864426e491306c6c37015a056ded50c68::momentum {
    fun effective_sqrt_price_limit_a_to_b(arg0: u128) : u128 {
        if (arg0 == 0) {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price()
        } else {
            arg0
        }
    }

    fun effective_sqrt_price_limit_b_to_a(arg0: u128) : u128 {
        if (arg0 == 0) {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price()
        } else {
            arg0
        }
    }

    public fun swap_exact_in<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        swap_exact_in_a_to_b<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun swap_exact_in_a_to_b<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg2);
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, true, true, v0, effective_sqrt_price_limit_a_to_b(arg4), arg5, arg1, arg6);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let (v7, v8) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        assert!(v7 == v0, 1);
        assert!(v8 == 0, 2);
        0x2::balance::join<T0>(&mut v6, arg2);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v4, v6, 0x2::balance::zero<T1>(), arg1, arg6);
        assert!(0x2::balance::value<T1>(&v5) >= arg3, 0);
        v5
    }

    public fun swap_exact_in_b_to_a<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg2);
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, false, true, v0, effective_sqrt_price_limit_b_to_a(arg4), arg5, arg1, arg6);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let (v7, v8) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        assert!(v7 == 0, 2);
        assert!(v8 == v0, 1);
        0x2::balance::join<T1>(&mut v5, arg2);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v4, 0x2::balance::zero<T0>(), v5, arg1, arg6);
        assert!(0x2::balance::value<T0>(&v6) >= arg3, 0);
        v6
    }

    // decompiled from Move bytecode v7
}

