module 0xfb54500b214bf96483fbfc175caf19c6c1c3b6198f8f5bae564d813f6c0776df::suiswap_amm {
    fun append<T0, T1>(arg0: &0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: 0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::RouteFormula, arg2: bool) : 0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::RouteFormula {
        assert_v2<T0, T1>(arg0);
        let (v0, v1, _) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::get_amounts<T0, T1>(arg0);
        let v3 = if (arg2) {
            v0
        } else {
            v1
        };
        let v4 = if (arg2) {
            v1
        } else {
            v0
        };
        0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::append_suiswap_v2_edge(arg1, v3, v4, 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_direction<T0, T1>(arg0), 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_admin<T0, T1>(arg0), 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_lp<T0, T1>(arg0), 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_th<T0, T1>(arg0), arg2)
    }

    public fun append_model_x_to_y<T0, T1>(arg0: &0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: 0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::RouteFormula) : 0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::RouteFormula {
        append<T0, T1>(arg0, arg1, true)
    }

    public fun append_model_y_to_x<T0, T1>(arg0: &0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: 0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::RouteFormula) : 0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::RouteFormula {
        append<T0, T1>(arg0, arg1, false)
    }

    fun assert_v2<T0, T1>(arg0: &0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>) {
        assert!(0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_pool_type<T0, T1>(arg0) == 100, 0);
    }

    fun model<T0, T1>(arg0: &0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: bool) : 0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::RouteFormula {
        assert_v2<T0, T1>(arg0);
        let (v0, v1, _) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::get_amounts<T0, T1>(arg0);
        let v3 = if (arg1) {
            v0
        } else {
            v1
        };
        let v4 = if (arg1) {
            v1
        } else {
            v0
        };
        0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::suiswap_v2_route(v3, v4, 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_direction<T0, T1>(arg0), 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_admin<T0, T1>(arg0), 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_lp<T0, T1>(arg0), 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_th<T0, T1>(arg0), arg1)
    }

    public fun model_x_to_y<T0, T1>(arg0: &0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>) : 0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::RouteFormula {
        model<T0, T1>(arg0, true)
    }

    public fun model_y_to_x<T0, T1>(arg0: &0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>) : 0xffeab358691e7aeb650fe80332326ef0e084828a7d9245c05dab762a1a65d268::optimizer::RouteFormula {
        model<T0, T1>(arg0, false)
    }

    public fun swap_exact_in_x_to_y<T0, T1>(arg0: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert_v2<T0, T1>(arg0);
        let v0 = 0x2::coin::from_balance<T0>(arg1, arg3);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v1, v0);
        let (v2, v3) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<T0, T1>(arg0, v1, 0x2::coin::value<T0>(&v0), arg2, arg3);
        let v4 = v3;
        assert!(0x2::coin::value<T1>(&v4) >= 1, 1);
        0x2::coin::destroy_zero<T0>(v2);
        0x2::coin::into_balance<T1>(v4)
    }

    public fun swap_exact_in_y_to_x<T0, T1>(arg0: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert_v2<T0, T1>(arg0);
        let v0 = 0x2::coin::from_balance<T1>(arg1, arg3);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v1, v0);
        let (v2, v3) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<T0, T1>(arg0, v1, 0x2::coin::value<T1>(&v0), arg2, arg3);
        let v4 = v3;
        assert!(0x2::coin::value<T0>(&v4) >= 1, 1);
        0x2::coin::destroy_zero<T1>(v2);
        0x2::coin::into_balance<T0>(v4)
    }

    // decompiled from Move bytecode v7
}

