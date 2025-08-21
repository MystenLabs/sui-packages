module 0xaaa34dc66329731adcc6ef0b4482fdff991efdb244f64167ef51fb6fb09a16d::suiprice {
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

    // decompiled from Move bytecode v6
}

