module 0xcdf5e38c3a437178d026eb336128f85a8a1b630972f8a3eb260fb1f76f822776::solve {
    public fun bisect(arg0: &vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>, arg1: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg2: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg3: u64) : 0xbd86d10b654f5e1e389aaaee1f0893a2a39d2ef0185499353b657b46b01db571::interval::Interval {
        assert!(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::le(arg1, arg2), 1);
        let (_, v1) = 0xcdf5e38c3a437178d026eb336128f85a8a1b630972f8a3eb260fb1f76f822776::poly::eval_bounds(arg0, arg1);
        assert!(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::le(v1, 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::zero()), 1);
        let (v2, _) = 0xcdf5e38c3a437178d026eb336128f85a8a1b630972f8a3eb260fb1f76f822776::poly::eval_bounds(arg0, arg2);
        assert!(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::le(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::zero(), v2), 1);
        let v4 = arg1;
        let v5 = arg2;
        let v6 = false;
        let v7 = 0;
        while (v7 < arg3 && !v6) {
            let (v8, v9, v10) = bisect_step(arg0, v4, v5);
            v4 = v8;
            v5 = v9;
            v6 = v10;
            v7 = v7 + 1;
        };
        0xbd86d10b654f5e1e389aaaee1f0893a2a39d2ef0185499353b657b46b01db571::interval::new(v4, v5)
    }

    fun bisect_step(arg0: &vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>, arg1: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg2: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : (0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, bool) {
        let v0 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::avg_down(arg1, arg2);
        let (v1, v2) = 0xcdf5e38c3a437178d026eb336128f85a8a1b630972f8a3eb260fb1f76f822776::poly::eval_bounds(arg0, v0);
        if (0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::le(v2, 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::zero())) {
            (v0, arg2, false)
        } else {
            let (v6, v7) = if (0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::le(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::zero(), v1)) {
                (v0, false)
            } else {
                (arg2, true)
            };
            (arg1, v6, v7)
        }
    }

    fun clamp(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg1: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg2: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::max(arg1, 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::min(arg0, arg2))
    }

    public fun fixed_point(arg0: &vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>, arg1: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg2: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg3: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg4: u64) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        assert!(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::le(arg1, arg2), 2);
        let v0 = clamp(arg3, arg1, arg2);
        let v1 = 0;
        while (v1 < arg4) {
            let (v2, _) = 0xcdf5e38c3a437178d026eb336128f85a8a1b630972f8a3eb260fb1f76f822776::poly::eval_bounds(arg0, v0);
            v0 = clamp(v2, arg1, arg2);
            v1 = v1 + 1;
        };
        v0
    }

    public fun newton(arg0: &vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>, arg1: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg2: u64) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let v0 = 0xcdf5e38c3a437178d026eb336128f85a8a1b630972f8a3eb260fb1f76f822776::poly::derivative(arg0);
        let v1 = arg1;
        let v2 = false;
        let v3 = 0;
        while (v3 < arg2 && !v2) {
            let (v4, v5) = newton_step(arg0, &v0, v1);
            v1 = v4;
            v2 = v5;
            v3 = v3 + 1;
        };
        v1
    }

    fun newton_step(arg0: &vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>, arg1: &vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>, arg2: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : (0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, bool) {
        let (v0, _) = 0xcdf5e38c3a437178d026eb336128f85a8a1b630972f8a3eb260fb1f76f822776::poly::eval_bounds(arg0, arg2);
        if (0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::le(v0, 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::zero())) {
            return (arg2, true)
        };
        let (_, v3) = 0xcdf5e38c3a437178d026eb336128f85a8a1b630972f8a3eb260fb1f76f822776::poly::eval_bounds(arg1, arg2);
        if (0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::le(v3, 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::zero())) {
            return (arg2, true)
        };
        let v4 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::div_down(v0, v3);
        if (0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::le(v4, 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::zero())) {
            return (arg2, true)
        };
        (0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::sub(arg2, v4), false)
    }

    // decompiled from Move bytecode v7
}

