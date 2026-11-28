module 0xb624ab9a113174039cd306cdacdc64da73b2633bfa078fb012e2d81f8d85ae4e::kernel {
    public(friend) fun exp_hi(arg0: u256) : u256 {
        horner(arg0, 190, 1, 1, true) + 1
    }

    public(friend) fun exp_lo(arg0: u256) : u256 {
        horner(arg0, 190, 1, 1, false)
    }

    public(friend) fun gint_hi(arg0: u256, arg1: u256) : u256 {
        let v0 = arg0 * arg0 * arg1;
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_up(horner(2 * v0, 180, 2, 3, true), arg0 * 300000000000000000000, exp_lo(v0)) + 1
    }

    public(friend) fun gint_lo(arg0: u256, arg1: u256) : u256 {
        let v0 = arg0 * arg0 * arg1;
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_down(horner(2 * v0, 180, 2, 3, false), arg0 * 300000000000000000000, exp_hi(v0))
    }

    public(friend) fun horner(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: bool) : u256 {
        let v0 = 300000000000000000000000000000000000000;
        let v1 = arg1;
        while (v1 > 0) {
            v1 = v1 - 1;
            let v2 = arg2 * v1 + arg3;
            let v3 = if (arg4) {
                (0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_up(v0, arg0, 300000000000000000000000000000000000000) + v2 - 1) / v2
            } else {
                0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_down(v0, arg0, 300000000000000000000000000000000000000) / v2
            };
            v0 = 300000000000000000000000000000000000000 + v3;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

