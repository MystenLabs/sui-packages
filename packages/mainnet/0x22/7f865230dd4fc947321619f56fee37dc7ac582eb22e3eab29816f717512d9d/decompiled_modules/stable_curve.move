module 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::stable_curve {
    public fun coin_out(arg0: u128, arg1: u64, arg2: u64, arg3: u128, arg4: u128) : u128 {
        assert!(arg1 > 0, 10001);
        assert!(arg2 > 0, 10002);
        let v0 = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::math::mul_div_u256((arg4 as u256), 1000000000, (arg2 as u256));
        (((v0 - get_y(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::math::mul_div_u256((arg0 as u256), 1000000000, (arg1 as u256)) + 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::math::mul_div_u256((arg3 as u256), 1000000000, (arg1 as u256)), lp_value(arg3, arg1, arg4, arg2), v0)) * (arg2 as u256) / 1000000000) as u128)
    }

    fun d(arg0: u256, arg1: u256) : u256 {
        3 * arg0 * arg1 * arg1 + arg0 * arg0 * arg0
    }

    fun f(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1 * arg1 * arg1 + arg0 * arg0 * arg0 * arg1
    }

    fun get_y(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = 0;
        let v1 = 1;
        while (v0 < 255) {
            let v2 = f(arg0, arg2);
            let v3 = if (v2 < arg1) {
                let v4 = (arg1 - v2) / d(arg0, arg2) + v1;
                arg2 = arg2 + v4;
                v4
            } else {
                let v5 = (v2 - arg1) / d(arg0, arg2);
                arg2 = arg2 - v5;
                v5
            };
            if (v3 == v1 || v3 < v1) {
                return arg2
            };
            v0 = v0 + 1;
        };
        arg2
    }

    public fun lp_value(arg0: u128, arg1: u64, arg2: u128, arg3: u64) : u256 {
        let v0 = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::math::mul_div_u256((arg0 as u256), 1000000000, (arg1 as u256));
        let v1 = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::math::mul_div_u256((arg2 as u256), 1000000000, (arg3 as u256));
        v0 * v1 * (v0 * v0 + v1 * v1)
    }

    // decompiled from Move bytecode v6
}

