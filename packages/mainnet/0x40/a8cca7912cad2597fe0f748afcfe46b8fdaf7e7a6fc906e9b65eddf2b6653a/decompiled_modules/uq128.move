module 0x40a8cca7912cad2597fe0f748afcfe46b8fdaf7e7a6fc906e9b65eddf2b6653a::uq128 {
    public fun add(arg0: u256, arg1: u256) : u256 {
        arg0 + arg1
    }

    public fun avg_down(arg0: u256, arg1: u256) : u256 {
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::average(arg0, arg1)
    }

    public fun avg_up(arg0: u256, arg1: u256) : u256 {
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::average_up(arg0, arg1)
    }

    public fun ceil(arg0: u256) : u256 {
        let v0 = arg0 >> 128;
        if (arg0 % 340282366920938463463374607431768211456 != 0) {
            assert!(v0 < 340282366920938463463374607431768211455, 1);
            v0 + 1 << 128
        } else {
            v0 << 128
        }
    }

    public fun div_down(arg0: u256, arg1: u256) : u256 {
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_down(arg0, 340282366920938463463374607431768211456, arg1)
    }

    public fun div_up(arg0: u256, arg1: u256) : u256 {
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_up(arg0, 340282366920938463463374607431768211456, arg1)
    }

    public fun floor(arg0: u256) : u256 {
        arg0 >> 128 << 128
    }

    public fun frac(arg0: u256) : u256 {
        arg0 % 340282366920938463463374607431768211456
    }

    public fun from_int(arg0: u128) : u256 {
        (arg0 as u256) << 128
    }

    public fun from_ud18_down(arg0: u256) : u256 {
        assert!(arg0 < 340282366920938463463374607431768211456000000000000000000, 1);
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_down(arg0, 340282366920938463463374607431768211456, 1000000000000000000)
    }

    public fun from_ud18_up(arg0: u256) : u256 {
        assert!(arg0 < 340282366920938463463374607431768211456000000000000000000, 1);
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_up(arg0, 340282366920938463463374607431768211456, 1000000000000000000)
    }

    public fun from_uq64(arg0: u128) : u256 {
        (arg0 as u256) << 64
    }

    public fun inv_down(arg0: u256) : u256 {
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_down(340282366920938463463374607431768211456, 340282366920938463463374607431768211456, arg0)
    }

    public fun inv_up(arg0: u256) : u256 {
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_up(340282366920938463463374607431768211456, 340282366920938463463374607431768211456, arg0)
    }

    public fun mul_down(arg0: u256, arg1: u256) : u256 {
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_shr_down(arg0, arg1, 128)
    }

    public fun mul_up(arg0: u256, arg1: u256) : u256 {
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_shr_up(arg0, arg1, 128)
    }

    public fun round(arg0: u256) : u256 {
        let v0 = arg0 >> 128;
        if (arg0 % 340282366920938463463374607431768211456 >= 170141183460469231731687303715884105728) {
            assert!(v0 < 340282366920938463463374607431768211455, 1);
            v0 + 1 << 128
        } else {
            v0 << 128
        }
    }

    public fun sub(arg0: u256, arg1: u256) : u256 {
        arg0 - arg1
    }

    public fun to_int_down(arg0: u256) : u128 {
        ((arg0 >> 128) as u128)
    }

    public fun to_int_up(arg0: u256) : u128 {
        let v0 = arg0 >> 128;
        if (arg0 % 340282366920938463463374607431768211456 != 0) {
            assert!(v0 < 340282366920938463463374607431768211455, 1);
            ((v0 + 1) as u128)
        } else {
            (v0 as u128)
        }
    }

    public fun to_ud18_down(arg0: u256) : u256 {
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_shr_down(arg0, 1000000000000000000, 128)
    }

    public fun to_ud18_up(arg0: u256) : u256 {
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_shr_up(arg0, 1000000000000000000, 128)
    }

    public fun to_uq64_down(arg0: u256) : u128 {
        let v0 = arg0 >> 64;
        assert!(v0 <= 340282366920938463463374607431768211455, 1);
        (v0 as u128)
    }

    public fun to_uq64_up(arg0: u256) : u128 {
        let v0 = if (arg0 % 18446744073709551616 != 0) {
            (arg0 >> 64) + 1
        } else {
            arg0 >> 64
        };
        assert!(v0 <= 340282366920938463463374607431768211455, 1);
        (v0 as u128)
    }

    // decompiled from Move bytecode v7
}

