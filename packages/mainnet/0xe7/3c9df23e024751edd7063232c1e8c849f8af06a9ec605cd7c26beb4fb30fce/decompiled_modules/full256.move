module 0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256 {
    public fun abs_diff(arg0: u256, arg1: u256) : u256 {
        if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun average(arg0: u256, arg1: u256) : u256 {
        if (arg0 <= arg1) {
            arg0 + (arg1 - arg0 >> 1)
        } else {
            arg1 + (arg0 - arg1 >> 1)
        }
    }

    public fun average_up(arg0: u256, arg1: u256) : u256 {
        if (arg0 <= arg1) {
            arg1 - (arg1 - arg0 >> 1)
        } else {
            arg0 - (arg0 - arg1 >> 1)
        }
    }

    public fun clamp(arg0: u256, arg1: u256, arg2: u256) : u256 {
        assert!(arg1 <= arg2, 4);
        if (arg0 < arg1) {
            arg1
        } else if (arg0 > arg2) {
            arg2
        } else {
            arg0
        }
    }

    public fun div_up(arg0: u256, arg1: u256) : u256 {
        assert!(arg1 != 0, 1);
        if (arg0 % arg1 != 0) {
            arg0 / arg1 + 1
        } else {
            arg0 / arg1
        }
    }

    public fun max(arg0: u256, arg1: u256) : u256 {
        if (arg0 <= arg1) {
            arg1
        } else {
            arg0
        }
    }

    public fun min(arg0: u256, arg1: u256) : u256 {
        if (arg0 <= arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun mul_div_down(arg0: u256, arg1: u256, arg2: u256) : u256 {
        assert!(arg2 != 0, 1);
        let v0 = 0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::mul_u256(arg0, arg1);
        let v1 = 0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::hi(v0);
        if (v1 == 0) {
            0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::lo(v0) / arg2
        } else {
            assert!(v1 < arg2, 2);
            let (v3, _) = 0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::div_rem_u256(v0, arg2);
            0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::lo(v3)
        }
    }

    public fun mul_div_up(arg0: u256, arg1: u256, arg2: u256) : u256 {
        assert!(arg2 != 0, 1);
        let v0 = 0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::mul_u256(arg0, arg1);
        let v1 = 0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::hi(v0);
        if (v1 == 0) {
            let v3 = 0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::lo(v0);
            if (v3 % arg2 != 0) {
                v3 / arg2 + 1
            } else {
                v3 / arg2
            }
        } else {
            assert!(v1 < arg2, 2);
            let (v4, v5) = 0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::div_rem_u256(v0, arg2);
            let v6 = 0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::lo(v4);
            if (v5 != 0) {
                assert!(v6 != 115792089237316195423570985008687907853269984665640564039457584007913129639935, 2);
                v6 + 1
            } else {
                v6
            }
        }
    }

    public fun mul_shr_down(arg0: u256, arg1: u256, arg2: u8) : u256 {
        let v0 = 0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::shr(0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::mul_u256(arg0, arg1), (arg2 as u16));
        assert!(0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::hi(v0) == 0, 2);
        0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::lo(v0)
    }

    public fun mul_shr_up(arg0: u256, arg1: u256, arg2: u8) : u256 {
        let v0 = 0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::mul_u256(arg0, arg1);
        let v1 = (arg2 as u16);
        let v2 = 0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::shr(v0, v1);
        assert!(0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::hi(v2) == 0, 2);
        let v3 = 0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::lo(v2);
        if (0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::eq(0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::shl(v2, v1), v0)) {
            v3
        } else {
            assert!(v3 != 115792089237316195423570985008687907853269984665640564039457584007913129639935, 2);
            v3 + 1
        }
    }

    public fun mul_wide(arg0: u256, arg1: u256) : 0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::U512 {
        0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::mul_u256(arg0, arg1)
    }

    public fun saturating_add(arg0: u256, arg1: u256) : u256 {
        if (arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg1) {
            115792089237316195423570985008687907853269984665640564039457584007913129639935
        } else {
            arg0 + arg1
        }
    }

    public fun saturating_mul(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0) {
            0
        } else if (arg1 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg0) {
            115792089237316195423570985008687907853269984665640564039457584007913129639935
        } else {
            arg0 * arg1
        }
    }

    public fun saturating_sub(arg0: u256, arg1: u256) : u256 {
        if (arg0 <= arg1) {
            0
        } else {
            arg0 - arg1
        }
    }

    public fun shl_checked(arg0: u256, arg1: u8) : u256 {
        if (arg1 > 255) {
            assert!(arg0 == 0, 3);
            0
        } else {
            assert!(arg0 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 >> arg1, 3);
            arg0 << arg1
        }
    }

    public fun wrapping_add(arg0: u256, arg1: u256) : u256 {
        let v0 = 115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg1;
        if (arg0 > v0) {
            arg0 - v0 - 1
        } else {
            arg0 + arg1
        }
    }

    public fun wrapping_mul(arg0: u256, arg1: u256) : u256 {
        0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::lo(0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512::mul_u256(arg0, arg1))
    }

    public fun wrapping_sub(arg0: u256, arg1: u256) : u256 {
        if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg1 - arg0 + 1
        }
    }

    // decompiled from Move bytecode v7
}

