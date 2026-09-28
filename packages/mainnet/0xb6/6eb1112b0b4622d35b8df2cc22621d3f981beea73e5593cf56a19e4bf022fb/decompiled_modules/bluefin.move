module 0xb66eb1112b0b4622d35b8df2cc22621d3f981beea73e5593cf56a19e4bf022fb::bluefin {
    fun limit(arg0: bool) : u128 {
        if (arg0) {
            4295048017
        } else {
            79226673515401279992447579054
        }
    }

    public fun quote<T0, T1>(arg0: &mut 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::Session, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: bool) {
        let v0 = vector[];
        let v1 = 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::quote_inputs(arg0);
        0x1::vector::reverse<u64>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v1)) {
            0x1::vector::push_back<u64>(&mut v0, simulate<T0, T1>(arg1, 0x1::vector::pop_back<u64>(&mut v1), arg2));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u64>(v1);
        0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::record_quote(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1), arg2, v0, vector[], vector[]);
    }

    fun simulate<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u64, arg2: bool) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, arg2, true, arg1, limit(arg2));
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v0) || 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v0) != 0) {
            return 0
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v0)
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::Session, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<T0>) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg4);
        assert!(v0 > 0, 1);
        let (v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg3, arg2, arg1, arg4, 0x2::balance::zero<T1>(), true, true, v0, 1, limit(true));
        let v3 = v2;
        0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::record_leg(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1), true, 0x2::balance::value<T1>(&v3));
        (v3, v1)
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::Session, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg4);
        assert!(v0 > 0, 1);
        let (v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg3, arg2, arg1, 0x2::balance::zero<T0>(), arg4, false, true, v0, 1, limit(false));
        let v3 = v1;
        0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::record_leg(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1), false, 0x2::balance::value<T0>(&v3));
        (v3, v2)
    }

    // decompiled from Move bytecode v7
}

