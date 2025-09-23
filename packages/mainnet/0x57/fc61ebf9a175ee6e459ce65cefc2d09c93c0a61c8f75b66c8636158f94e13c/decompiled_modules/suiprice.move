module 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::suiprice {
    public fun get_amount_out<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg1: u64, arg2: bool) : u64 {
        abort 400
    }

    public fun get_amount_out_v2<T0>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: bool) : u64 {
        abort 401
    }

    public fun get_amount_out_v3<T0>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg1: u64, arg2: bool) : u64 {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0x1::ascii::string(b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC"), 1);
        assert!(0x2::object::id_address<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>>(arg0) == @0x455cf8d2ac91e7cb883f515874af750ed3cd18195c970b7a2d46235ac2b0c388, 2);
        let v0 = if (arg2) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<0x2::sui::SUI, T0>(arg0, arg2, true, v0, arg1);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v1)
    }

    public fun get_suil_amount_out(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x11f15e1c9e1a49cd26d4c442b5911dc87585440969f9a18d9c171e2acd21ac1b::suil::SUIL, 0x2::sui::SUI>, arg1: u64, arg2: bool) : u64 {
        assert!(0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x11f15e1c9e1a49cd26d4c442b5911dc87585440969f9a18d9c171e2acd21ac1b::suil::SUIL, 0x2::sui::SUI>>(arg0) == @0xcf3521e0e48ab598029fcf85ed1bcea6369cd45183feb37f0a0487e50c667f06, 2);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0x11f15e1c9e1a49cd26d4c442b5911dc87585440969f9a18d9c171e2acd21ac1b::suil::SUIL, 0x2::sui::SUI>(arg0, !arg2, true, arg1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0)
    }

    public fun get_suil_usd_amount_out<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x11f15e1c9e1a49cd26d4c442b5911dc87585440969f9a18d9c171e2acd21ac1b::suil::SUIL, 0x2::sui::SUI>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg2: u64) : u64 {
        get_amount_out_v3<T0>(arg1, get_suil_amount_out(arg0, arg2, false), true)
    }

    public fun get_usd_suil_amount_out<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x11f15e1c9e1a49cd26d4c442b5911dc87585440969f9a18d9c171e2acd21ac1b::suil::SUIL, 0x2::sui::SUI>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg2: u64) : u64 {
        get_suil_amount_out(arg0, get_amount_out_v3<T0>(arg1, arg2, false), true)
    }

    // decompiled from Move bytecode v6
}

