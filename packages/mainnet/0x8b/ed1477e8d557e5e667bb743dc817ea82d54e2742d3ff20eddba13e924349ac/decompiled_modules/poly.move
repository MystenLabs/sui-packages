module 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::poly {
    public fun add(arg0: vector<u256>, arg1: vector<u256>, arg2: u256) : vector<u256> {
        assert!(arg2 != 0, 1);
        let v0 = 0x1::vector::length<u256>(&arg0);
        let v1 = 0x1::vector::length<u256>(&arg1);
        let v2 = if (v0 > v1) {
            v0
        } else {
            v1
        };
        let v3 = vector[];
        let v4 = 0;
        while (v4 < v2) {
            let v5 = if (v4 < v0) {
                *0x1::vector::borrow<u256>(&arg0, v4)
            } else {
                0
            };
            let v6 = if (v4 < v1) {
                *0x1::vector::borrow<u256>(&arg1, v4)
            } else {
                0
            };
            0x1::vector::push_back<u256>(&mut v3, 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::add(v5, v6, arg2));
            v4 = v4 + 1;
        };
        v3
    }

    public fun mul(arg0: vector<u256>, arg1: vector<u256>, arg2: u256) : vector<u256> {
        assert!(arg2 != 0, 1);
        let v0 = 0x1::vector::length<u256>(&arg0);
        let v1 = 0x1::vector::length<u256>(&arg1);
        if (v0 == 0 || v1 == 0) {
            return vector[]
        };
        let v2 = v0 + v1 - 1;
        assert!(v2 <= 262144, 2);
        let v3 = vector[];
        let v4 = 0;
        while (v4 < v2) {
            0x1::vector::push_back<u256>(&mut v3, conv_at(arg0, arg1, v4, arg2));
            v4 = v4 + 1;
        };
        v3
    }

    public fun sub(arg0: vector<u256>, arg1: vector<u256>, arg2: u256) : vector<u256> {
        assert!(arg2 != 0, 1);
        let v0 = 0x1::vector::length<u256>(&arg0);
        let v1 = 0x1::vector::length<u256>(&arg1);
        let v2 = if (v0 > v1) {
            v0
        } else {
            v1
        };
        let v3 = vector[];
        let v4 = 0;
        while (v4 < v2) {
            let v5 = if (v4 < v0) {
                *0x1::vector::borrow<u256>(&arg0, v4)
            } else {
                0
            };
            let v6 = if (v4 < v1) {
                *0x1::vector::borrow<u256>(&arg1, v4)
            } else {
                0
            };
            0x1::vector::push_back<u256>(&mut v3, 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::sub(v5, v6, arg2));
            v4 = v4 + 1;
        };
        v3
    }

    fun conv_at(arg0: vector<u256>, arg1: vector<u256>, arg2: u64, arg3: u256) : u256 {
        let v0 = 0x1::vector::length<u256>(&arg1);
        let v1 = if (arg2 >= v0) {
            arg2 - v0 + 1
        } else {
            0
        };
        let v2 = v1;
        let v3 = 0;
        while (v2 <= arg2 && v2 < 0x1::vector::length<u256>(&arg0)) {
            v3 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::add(v3, 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(*0x1::vector::borrow<u256>(&arg0, v2), *0x1::vector::borrow<u256>(&arg1, arg2 - v2), arg3), arg3);
            v2 = v2 + 1;
        };
        v3
    }

    public fun eval(arg0: vector<u256>, arg1: u256, arg2: u256) : u256 {
        assert!(arg2 != 0, 1);
        let v0 = 0;
        let v1 = 0x1::vector::length<u256>(&arg0);
        while (v1 > 0) {
            v1 = v1 - 1;
            let v2 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(v0, arg1, arg2);
            v0 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::add(v2, *0x1::vector::borrow<u256>(&arg0, v1), arg2);
        };
        v0
    }

    public fun scale(arg0: vector<u256>, arg1: u256, arg2: u256) : vector<u256> {
        assert!(arg2 != 0, 1);
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<u256>(&arg0)) {
            0x1::vector::push_back<u256>(&mut v0, 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg1, *0x1::vector::borrow<u256>(&arg0, v1), arg2));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

