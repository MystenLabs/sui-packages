module 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::polynomial {
    struct Polynomial has copy, drop, store {
        coefficients: vector<u8>,
    }

    fun add(arg0: &Polynomial, arg1: &Polynomial) : Polynomial {
        let v0 = 0x1::vector::length<u8>(&arg0.coefficients);
        let v1 = 0x1::vector::length<u8>(&arg1.coefficients);
        if (v0 < v1) {
            return add(arg1, arg0)
        };
        let v2 = b"";
        let v3 = 0;
        while (v3 < v0) {
            let v4 = if (v3 < v1) {
                0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::gf256::add(*0x1::vector::borrow<u8>(&arg0.coefficients, v3), *0x1::vector::borrow<u8>(&arg1.coefficients, v3))
            } else {
                *0x1::vector::borrow<u8>(&arg0.coefficients, v3)
            };
            0x1::vector::push_back<u8>(&mut v2, v4);
            v3 = v3 + 1;
        };
        let v5 = Polynomial{coefficients: v2};
        reduce(v5);
        v5
    }

    fun div(arg0: &Polynomial, arg1: u8) : Polynomial {
        scale(arg0, 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::gf256::div(1, arg1))
    }

    fun mul(arg0: &Polynomial, arg1: &Polynomial) : Polynomial {
        let v0 = b"";
        let v1 = 0;
        while (v1 < degree(arg0) + degree(arg1) + 1) {
            let v2 = 0;
            let v3 = 0;
            if (v3 > v1) {
            } else {
                loop {
                    if (v3 <= degree(arg0) && v1 - v3 <= degree(arg1)) {
                        v2 = 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::gf256::add(v2, 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::gf256::mul(*0x1::vector::borrow<u8>(&arg0.coefficients, v3), *0x1::vector::borrow<u8>(&arg1.coefficients, v1 - v3)));
                    };
                    if (v3 >= v1) {
                        break
                    };
                    v3 = v3 + 1;
                };
            };
            0x1::vector::push_back<u8>(&mut v0, v2);
            v1 = v1 + 1;
        };
        let v4 = Polynomial{coefficients: v0};
        reduce(v4);
        v4
    }

    fun degree(arg0: &Polynomial) : u64 {
        0x1::vector::length<u8>(&arg0.coefficients) - 1
    }

    public fun evaluate(arg0: &Polynomial, arg1: u8) : u8 {
        let v0 = 0;
        let v1 = 0x1::vector::length<u8>(&arg0.coefficients);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::gf256::mul(v0, arg1);
            v0 = 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::gf256::add(v3, *0x1::vector::borrow<u8>(&arg0.coefficients, v1 - v2 - 1));
            v2 = v2 + 1;
        };
        v0
    }

    public(friend) fun get_constant_term(arg0: &Polynomial) : u8 {
        if (0x1::vector::is_empty<u8>(&arg0.coefficients)) {
            return 0
        };
        *0x1::vector::borrow<u8>(&arg0.coefficients, 0)
    }

    public(friend) fun interpolate(arg0: &vector<u8>, arg1: &vector<u8>) : Polynomial {
        assert!(0x1::vector::length<u8>(arg0) == 0x1::vector::length<u8>(arg1), 13906834526530699263);
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = Polynomial{coefficients: 0x1::vector::empty<u8>()};
        let v2 = 0;
        while (v2 < v0) {
            let v3 = Polynomial{coefficients: x"01"};
            let v4 = 0;
            while (v4 < v0) {
                if (v4 != v2) {
                    let v5 = &v3;
                    let v6 = monic_linear(0x1::vector::borrow<u8>(arg0, v4));
                    let v7 = div(&v6, 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::gf256::sub(*0x1::vector::borrow<u8>(arg0, v2), *0x1::vector::borrow<u8>(arg0, v4)));
                    v3 = mul(v5, &v7);
                };
                v4 = v4 + 1;
            };
            let v8 = &v1;
            let v9 = scale(&v3, *0x1::vector::borrow<u8>(arg1, v2));
            v1 = add(v8, &v9);
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun interpolate_all(arg0: &vector<u8>, arg1: &vector<vector<u8>>) : vector<Polynomial> {
        assert!(0x1::vector::length<u8>(arg0) == 0x1::vector::length<vector<u8>>(arg1), 13906834625314947071);
        let v0 = 0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(arg1, 0));
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<vector<u8>>(arg1)) {
            if (!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(arg1, v1)) == v0)) {
                v2 = false;
                /* label 6 */
                assert!(v2, 13906834633904881663);
                let v3 = 0x1::vector::empty<Polynomial>();
                let v4 = 0;
                while (v4 < v0) {
                    let v5 = b"";
                    let v6 = 0;
                    while (v6 < 0x1::vector::length<vector<u8>>(arg1)) {
                        0x1::vector::push_back<u8>(&mut v5, *0x1::vector::borrow<u8>(0x1::vector::borrow<vector<u8>>(arg1, v6), v4));
                        v6 = v6 + 1;
                    };
                    0x1::vector::push_back<Polynomial>(&mut v3, interpolate(arg0, &v5));
                    v4 = v4 + 1;
                };
                return v3
            };
            v1 = v1 + 1;
        };
        v2 = true;
        /* goto 6 */
    }

    fun monic_linear(arg0: &u8) : Polynomial {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::gf256::sub(0, *arg0));
        0x1::vector::push_back<u8>(v1, 1);
        Polynomial{coefficients: v0}
    }

    fun reduce(arg0: Polynomial) {
        while (0x1::vector::length<u8>(&arg0.coefficients) > 0 && *0x1::vector::borrow<u8>(&arg0.coefficients, 0x1::vector::length<u8>(&arg0.coefficients) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut arg0.coefficients);
        };
    }

    fun scale(arg0: &Polynomial, arg1: u8) : Polynomial {
        let v0 = &arg0.coefficients;
        let v1 = b"";
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v0)) {
            0x1::vector::push_back<u8>(&mut v1, 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::gf256::mul(*0x1::vector::borrow<u8>(v0, v2), arg1));
            v2 = v2 + 1;
        };
        Polynomial{coefficients: v1}
    }

    // decompiled from Move bytecode v6
}

