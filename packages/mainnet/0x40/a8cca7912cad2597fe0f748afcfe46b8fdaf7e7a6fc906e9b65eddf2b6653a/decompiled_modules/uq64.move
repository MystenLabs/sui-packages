module 0x40a8cca7912cad2597fe0f748afcfe46b8fdaf7e7a6fc906e9b65eddf2b6653a::uq64 {
    public fun add(arg0: u128, arg1: u128) : u128 {
        arg0 + arg1
    }

    public fun avg_down(arg0: u128, arg1: u128) : u128 {
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full128::average(arg0, arg1)
    }

    public fun avg_up(arg0: u128, arg1: u128) : u128 {
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full128::average_up(arg0, arg1)
    }

    public fun ceil(arg0: u128) : u128 {
        let v0 = arg0 >> 64;
        if (arg0 % 18446744073709551616 != 0) {
            assert!(v0 < 18446744073709551615, 1);
            v0 + 1 << 64
        } else {
            v0 << 64
        }
    }

    public fun div_down(arg0: u128, arg1: u128) : u128 {
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full128::mul_div_down(arg0, 18446744073709551616, arg1)
    }

    public fun div_up(arg0: u128, arg1: u128) : u128 {
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full128::mul_div_up(arg0, 18446744073709551616, arg1)
    }

    public fun floor(arg0: u128) : u128 {
        arg0 >> 64 << 64
    }

    public fun frac(arg0: u128) : u128 {
        arg0 % 18446744073709551616
    }

    public fun from_int(arg0: u64) : u128 {
        (arg0 as u128) << 64
    }

    public fun from_ud18_down(arg0: u256) : u128 {
        assert!(arg0 < 18446744073709551616000000000000000000, 1);
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full128::mul_div_down((arg0 as u128), 18446744073709551616, 1000000000000000000)
    }

    public fun from_ud18_up(arg0: u256) : u128 {
        assert!(arg0 < 18446744073709551616000000000000000000, 1);
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full128::mul_div_up((arg0 as u128), 18446744073709551616, 1000000000000000000)
    }

    public fun inv_down(arg0: u128) : u128 {
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full128::mul_div_down(18446744073709551616, 18446744073709551616, arg0)
    }

    public fun inv_up(arg0: u128) : u128 {
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full128::mul_div_up(18446744073709551616, 18446744073709551616, arg0)
    }

    public fun mul_down(arg0: u128, arg1: u128) : u128 {
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full128::mul_shr_down(arg0, arg1, 64)
    }

    public fun mul_up(arg0: u128, arg1: u128) : u128 {
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full128::mul_shr_up(arg0, arg1, 64)
    }

    public fun round(arg0: u128) : u128 {
        let v0 = arg0 >> 64;
        if (arg0 % 18446744073709551616 >= 9223372036854775808) {
            assert!(v0 < 18446744073709551615, 1);
            v0 + 1 << 64
        } else {
            v0 << 64
        }
    }

    public fun sub(arg0: u128, arg1: u128) : u128 {
        arg0 - arg1
    }

    public fun to_int_down(arg0: u128) : u64 {
        ((arg0 >> 64) as u64)
    }

    public fun to_int_up(arg0: u128) : u64 {
        let v0 = arg0 >> 64;
        if (arg0 % 18446744073709551616 != 0) {
            assert!(v0 < 18446744073709551615, 1);
            ((v0 + 1) as u64)
        } else {
            (v0 as u64)
        }
    }

    public fun to_ud18_down(arg0: u128) : u256 {
        (0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full128::mul_shr_down(arg0, 1000000000000000000, 64) as u256)
    }

    public fun to_ud18_up(arg0: u128) : u256 {
        (0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full128::mul_shr_up(arg0, 1000000000000000000, 64) as u256)
    }

    // decompiled from Move bytecode v7
}

