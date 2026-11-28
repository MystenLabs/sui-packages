module 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::lagrange {
    fun basis_at(arg0: vector<u256>, arg1: u64, arg2: u256, arg3: u256) : (u256, u256) {
        let v0 = 1 % arg3;
        let v1 = 1 % arg3;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u256>(&arg0)) {
            if (v2 != arg1) {
                let v3 = *0x1::vector::borrow<u256>(&arg0, v2);
                v0 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(v0, 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::sub(arg2, v3, arg3), arg3);
                v1 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(v1, 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::sub(*0x1::vector::borrow<u256>(&arg0, arg1), v3, arg3), arg3);
            };
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun interpolate_at(arg0: vector<u256>, arg1: vector<u256>, arg2: u256, arg3: u256) : u256 {
        let v0 = 0x1::vector::length<u256>(&arg0);
        assert!(0x1::vector::length<u256>(&arg1) == v0, 1);
        assert!(arg3 != 0, 2);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            let (v3, v4) = basis_at(arg0, v2, arg2, arg3);
            v1 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::add(v1, 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(*0x1::vector::borrow<u256>(&arg1, v2), 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(v3, 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::inv(v4, arg3), arg3), arg3), arg3);
            v2 = v2 + 1;
        };
        v1
    }

    public fun shamir_reconstruct(arg0: vector<u256>, arg1: vector<u256>, arg2: u256) : u256 {
        interpolate_at(arg0, arg1, 0, arg2)
    }

    // decompiled from Move bytecode v7
}

