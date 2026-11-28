module 0xa3a4e15175d34827bdd41b4faba10a93087a478e2f80c0ea16ce8c7969985d81::ema {
    public fun ema_down(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18, arg1: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18, arg2: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18 {
        assert!(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(arg2) <= 1000000000000000000, 1);
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(arg0);
        let v1 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(arg1);
        if (v1 >= v0) {
            0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(v0 + 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::mul_down(arg2, 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(v1 - v0))))
        } else {
            0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(v0 - 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::mul_up(arg2, 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(v0 - v1))))
        }
    }

    public fun ema_up(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18, arg1: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18, arg2: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18 {
        assert!(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(arg2) <= 1000000000000000000, 1);
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(arg0);
        let v1 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(arg1);
        if (v1 >= v0) {
            0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(v0 + 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::mul_up(arg2, 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(v1 - v0))))
        } else {
            0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(v0 - 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::mul_down(arg2, 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(v0 - v1))))
        }
    }

    public fun twap_accumulate(arg0: u256, arg1: u256, arg2: u64) : u256 {
        arg0 + arg1 * (arg2 as u256)
    }

    public fun twap_down(arg0: u256, arg1: u64, arg2: u256, arg3: u64) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18 {
        assert!(arg3 > arg1, 2);
        assert!(arg2 >= arg0, 3);
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap((arg2 - arg0) / ((arg3 - arg1) as u256))
    }

    public fun twap_up(arg0: u256, arg1: u64, arg2: u256, arg3: u64) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18 {
        assert!(arg3 > arg1, 2);
        assert!(arg2 >= arg0, 3);
        let v0 = ((arg3 - arg1) as u256);
        let v1 = arg2 - arg0;
        let v2 = if (v1 % v0 != 0) {
            v1 / v0 + 1
        } else {
            v1 / v0
        };
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(v2)
    }

    // decompiled from Move bytecode v7
}

