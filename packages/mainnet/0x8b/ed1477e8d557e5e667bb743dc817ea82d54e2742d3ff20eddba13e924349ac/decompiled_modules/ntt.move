module 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::ntt {
    public fun ntt(arg0: vector<u256>, arg1: u256, arg2: u256) : vector<u256> {
        assert!(arg2 != 0, 1);
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<u256>(&arg0)) {
            0x1::vector::push_back<u256>(&mut v0, 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::poly::eval(arg0, 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::pow(arg1, (v1 as u256), arg2), arg2));
            v1 = v1 + 1;
        };
        v0
    }

    public fun intt(arg0: vector<u256>, arg1: u256, arg2: u256) : vector<u256> {
        assert!(arg2 != 0, 1);
        let v0 = 0x1::vector::length<u256>(&arg0);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<u256>(&mut v1, 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::poly::eval(arg0, 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::pow(0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::inv(arg1, arg2), (v2 as u256), arg2), arg2), 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::inv((v0 as u256), arg2), arg2));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v7
}

