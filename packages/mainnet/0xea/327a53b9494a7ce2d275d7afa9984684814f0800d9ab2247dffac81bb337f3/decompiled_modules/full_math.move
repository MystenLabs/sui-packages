module 0xea327a53b9494a7ce2d275d7afa9984684814f0800d9ab2247dffac81bb337f3::full_math {
    public fun max(arg0: u128, arg1: u128) : u128 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun min(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun mul_div(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 0);
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u128)
    }

    public fun mul_div_ceil(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 0);
        ((((arg0 as u256) * (arg1 as u256) + ((arg2 - 1) as u256)) / (arg2 as u256)) as u128)
    }

    public fun sqrt(arg0: u128) : u128 {
        if (arg0 == 0 || arg0 == 1) {
            return arg0
        };
        let v0 = arg0 / 2 + 1;
        while (v0 < arg0) {
            let v1 = arg0 / v0 + v0;
            v0 = v1 / 2;
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

