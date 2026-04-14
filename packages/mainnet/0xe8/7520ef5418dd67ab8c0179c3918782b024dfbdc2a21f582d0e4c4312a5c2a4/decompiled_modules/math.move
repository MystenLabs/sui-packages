module 0xe87520ef5418dd67ab8c0179c3918782b024dfbdc2a21f582d0e4c4312a5c2a4::math {
    public fun apply_stat_scaling(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let (v0, v1) = signed_sub(arg1, arg2);
        if (v1) {
            saturating_sub(arg0, mul(v0, div(arg3, arg4)))
        } else {
            arg0 + mul(v0, div(arg3, arg4))
        }
    }

    public fun clamp(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 < arg1) {
            arg1
        } else if (arg0 > arg2) {
            arg2
        } else {
            arg0
        }
    }

    public fun curve_strong(arg0: u64) : u64 {
        sqrt_u64(arg0 * 10000)
    }

    public fun curve_weak(arg0: u64) : u64 {
        mul(arg0, arg0)
    }

    public fun div(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 > 0, 0);
        (((arg0 as u128) * (10000 as u128) / (arg1 as u128)) as u64)
    }

    public fun lerp(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 <= arg0) {
            return arg0
        };
        arg0 + mul(arg1 - arg0, arg2)
    }

    public fun mul(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun saturating_sub(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    public fun scale() : u64 {
        10000
    }

    public fun signed_sub(arg0: u64, arg1: u64) : (u64, bool) {
        if (arg0 >= arg1) {
            (arg0 - arg1, false)
        } else {
            (arg1 - arg0, true)
        }
    }

    public fun sqrt_u64(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        arg0
    }

    // decompiled from Move bytecode v7
}

