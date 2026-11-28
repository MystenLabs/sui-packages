module 0xb6a4c6356ba6de5d1fe19a47bd55ccc187b3c98dcb5274024f9af9b21d54750f::exp_kernel {
    public(friend) fun frac2_down(arg0: u256) : u256 {
        half_down(arg0 * 693147180559945309417232121458000000 / 1000000000000000000)
    }

    public(friend) fun frac2_up(arg0: u256) : u256 {
        half_up((arg0 * 693147180559945309417232121459000000 + 1000000000000000000 - 1) / 1000000000000000000)
    }

    public(friend) fun half_down(arg0: u256) : u256 {
        sq_down(sq_down(sq_down(sq_down(sq_down(sq_down(sq_down(taylor_down(arg0), 1000000000000000000000000000000000000), 1000000000000000000000000000000000000), 1000000000000000000000000000000000000), 1000000000000000000000000000000000000), 1000000000000000000000000000000000000), 1000000000000000000000000000000000000), 1000000000000000000000000000000000000)
    }

    public(friend) fun half_up(arg0: u256) : u256 {
        sq_up(sq_up(sq_up(sq_up(sq_up(sq_up(sq_up(taylor_up(arg0), 1000000000000000000000000000000000000), 1000000000000000000000000000000000000), 1000000000000000000000000000000000000), 1000000000000000000000000000000000000), 1000000000000000000000000000000000000), 1000000000000000000000000000000000000), 1000000000000000000000000000000000000)
    }

    public(friend) fun neg_down(arg0: u256) : u256 {
        if (arg0 > 64000000000000000000) {
            0
        } else {
            1000000000000000000000000000000000000000000000000000000 / sq_up(half_up(arg0 * 1000000000000000000), 1000000000000000000000000000000000000)
        }
    }

    public(friend) fun neg_up(arg0: u256) : u256 {
        if (arg0 > 64000000000000000000) {
            1
        } else {
            0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::div_up(1000000000000000000000000000000000000000000000000000000, sq_down(half_down(arg0 * 1000000000000000000), 1000000000000000000000000000000000000))
        }
    }

    public(friend) fun pos_down(arg0: u256) : u256 {
        sq_down(half_down(arg0 * 1000000000000000000), 1000000000000000000000000000000000000000000000000000000)
    }

    public(friend) fun pos_up(arg0: u256) : u256 {
        sq_up(half_up(arg0 * 1000000000000000000), 1000000000000000000000000000000000000000000000000000000)
    }

    public(friend) fun pow2_div_down(arg0: u256, arg1: u256) : u256 {
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_down(arg0, arg0, 1000000000000000000000000000000000000000000000000000000 << (arg1 as u8))
    }

    public(friend) fun pow2_div_up(arg0: u256, arg1: u256) : u256 {
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_up(arg0, arg0, 1000000000000000000000000000000000000000000000000000000 << (arg1 as u8))
    }

    public(friend) fun pow2_mul_down(arg0: u256, arg1: u256) : u256 {
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_down(arg0 << ((arg1 / 2) as u8), arg0 << ((arg1 - arg1 / 2) as u8), 1000000000000000000000000000000000000000000000000000000)
    }

    public(friend) fun pow2_mul_up(arg0: u256, arg1: u256) : u256 {
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_up(arg0 << ((arg1 / 2) as u8), arg0 << ((arg1 - arg1 / 2) as u8), 1000000000000000000000000000000000000000000000000000000)
    }

    public(friend) fun pow2_neg_down(arg0: u256) : u256 {
        let v0 = (arg0 + 1000000000000000000 - 1) / 1000000000000000000;
        if (v0 > 64) {
            0
        } else {
            pow2_div_down(frac2_down(v0 * 1000000000000000000 - arg0), v0)
        }
    }

    public(friend) fun pow2_neg_up(arg0: u256) : u256 {
        let v0 = (arg0 + 1000000000000000000 - 1) / 1000000000000000000;
        if (v0 > 64) {
            1
        } else {
            pow2_div_up(frac2_up(v0 * 1000000000000000000 - arg0), v0)
        }
    }

    public(friend) fun pow2_pos_down(arg0: u256) : u256 {
        pow2_mul_down(frac2_down(arg0 % 1000000000000000000), arg0 / 1000000000000000000)
    }

    public(friend) fun pow2_pos_up(arg0: u256) : u256 {
        pow2_mul_up(frac2_up(arg0 % 1000000000000000000), arg0 / 1000000000000000000)
    }

    public(friend) fun sq_down(arg0: u256, arg1: u256) : u256 {
        if (arg0 < 340282366920938463463374607431768211456) {
            arg0 * arg0 / arg1
        } else {
            0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_down(arg0, arg0, arg1)
        }
    }

    public(friend) fun sq_up(arg0: u256, arg1: u256) : u256 {
        if (arg0 < 340282366920938463463374607431768211456) {
            let v1 = arg0 * arg0;
            if (v1 % arg1 == 0) {
                v1 / arg1
            } else {
                v1 / arg1 + 1
            }
        } else {
            0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_up(arg0, arg0, arg1)
        }
    }

    public(friend) fun taylor_down(arg0: u256) : u256 {
        let v0 = 1000000000000000000000000000000000000;
        let v1 = 1000000000000000000000000000000000000;
        let v2 = 1;
        while (v2 < 30) {
            v0 = v0 * arg0 / v2 * 256000000000000000000000000000000000000;
            v1 = v1 + v0;
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun taylor_up(arg0: u256) : u256 {
        let v0 = 1000000000000000000000000000000000000;
        let v1 = if (arg0 == 0) {
            1000000000000000000000000000000000000
        } else {
            1000000000000000000000000000000000000 + 1
        };
        let v2 = v1;
        let v3 = 1;
        while (v3 < 30) {
            let v4 = v3 * 256000000000000000000000000000000000000;
            v0 = (v0 * arg0 + v4 - 1) / v4;
            v2 = v2 + v0;
            v3 = v3 + 1;
        };
        v2
    }

    // decompiled from Move bytecode v7
}

