module 0xcdf5e38c3a437178d026eb336128f85a8a1b630972f8a3eb260fb1f76f822776::poly {
    fun bounds_step(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg1: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg2: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg3: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : (0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) {
        (0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::add(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::mul_down(arg0, arg2), arg3), 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::add(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::mul_up(arg1, arg2), arg3))
    }

    public fun derivative(arg0: &vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>) : vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18> {
        let v0 = 0x1::vector::empty<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>();
        let v1 = 1;
        while (v1 < 0x1::vector::length<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>(arg0)) {
            0x1::vector::push_back<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>(&mut v0, 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::mul_down(*0x1::vector::borrow<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>(arg0, v1), 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits((v1 as u256) * 1000000000000000000))));
            v1 = v1 + 1;
        };
        v0
    }

    public fun eval_bounds(arg0: &vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>, arg1: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : (0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) {
        let v0 = 0x1::vector::length<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>(arg0);
        let v1 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::zero();
        let v2 = 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::zero();
        let v3 = 0;
        while (v3 < v0) {
            let (v4, v5) = step_bounds(v1, v2, arg1, *0x1::vector::borrow<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>(arg0, v0 - 1 - v3));
            v1 = v4;
            v2 = v5;
            v3 = v3 + 1;
        };
        (v1, v2)
    }

    public fun eval_comp(arg0: &vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>, arg1: &vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>, arg2: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0xbd86d10b654f5e1e389aaaee1f0893a2a39d2ef0185499353b657b46b01db571::interval::Interval {
        let (v0, v1) = eval_bounds(arg1, arg2);
        eval_range(arg0, 0xbd86d10b654f5e1e389aaaee1f0893a2a39d2ef0185499353b657b46b01db571::interval::new(v0, v1))
    }

    public fun eval_down(arg0: &vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>, arg1: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let (v0, _) = eval_bounds(arg0, arg1);
        v0
    }

    public fun eval_range(arg0: &vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>, arg1: 0xbd86d10b654f5e1e389aaaee1f0893a2a39d2ef0185499353b657b46b01db571::interval::Interval) : 0xbd86d10b654f5e1e389aaaee1f0893a2a39d2ef0185499353b657b46b01db571::interval::Interval {
        let v0 = 0x1::vector::length<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>(arg0);
        let v1 = 0xbd86d10b654f5e1e389aaaee1f0893a2a39d2ef0185499353b657b46b01db571::interval::point(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::zero());
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0xbd86d10b654f5e1e389aaaee1f0893a2a39d2ef0185499353b657b46b01db571::interval::mul(v1, arg1);
            v1 = 0xbd86d10b654f5e1e389aaaee1f0893a2a39d2ef0185499353b657b46b01db571::interval::add(v3, 0xbd86d10b654f5e1e389aaaee1f0893a2a39d2ef0185499353b657b46b01db571::interval::point(*0x1::vector::borrow<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>(arg0, v0 - 1 - v2)));
            v2 = v2 + 1;
        };
        v1
    }

    public fun eval_up(arg0: &vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>, arg1: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        let (_, v1) = eval_bounds(arg0, arg1);
        v1
    }

    fun step_bounds(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg1: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg2: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, arg3: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) : (0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18, 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18) {
        if (0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::le(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::zero(), arg2)) {
            bounds_step(arg0, arg1, arg2, arg3)
        } else {
            bounds_step(arg1, arg0, arg2, arg3)
        }
    }

    // decompiled from Move bytecode v7
}

