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
        Polynomial{coefficients: v2}
    }

    fun mul(arg0: &Polynomial, arg1: &Polynomial) : Polynomial {
        if (0x1::vector::is_empty<u8>(&arg0.coefficients) || 0x1::vector::is_empty<u8>(&arg1.coefficients)) {
            return Polynomial{coefficients: b""}
        };
        let v0 = b"";
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0.coefficients) + 0x1::vector::length<u8>(&arg1.coefficients) - 1) {
            let v2 = 0;
            let v3 = 0;
            if (v3 > v1) {
            } else {
                loop {
                    if (v3 < 0x1::vector::length<u8>(&arg0.coefficients) && v1 - v3 < 0x1::vector::length<u8>(&arg1.coefficients)) {
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
        Polynomial{coefficients: v0}
    }

    fun compute_numerators(arg0: vector<u8>) : vector<Polynomial> {
        let v0 = Polynomial{coefficients: x"01"};
        0x1::vector::reverse<u8>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            let v2 = v0;
            let v3 = 0x1::vector::pop_back<u8>(&mut arg0);
            let v4 = monic_linear(&v3);
            v0 = mul(&v2, &v4);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u8>(arg0);
        let v5 = v0;
        let v6 = &arg0;
        let v7 = 0x1::vector::empty<Polynomial>();
        let v8 = 0;
        while (v8 < 0x1::vector::length<u8>(v6)) {
            0x1::vector::push_back<Polynomial>(&mut v7, div_by_monic_linear(&v5, *0x1::vector::borrow<u8>(v6, v8)));
            v8 = v8 + 1;
        };
        v7
    }

    fun div_by_monic_linear(arg0: &Polynomial, arg1: u8) : Polynomial {
        let v0 = 0x1::vector::length<u8>(&arg0.coefficients);
        let v1 = 0x1::vector::empty<u8>();
        if (v0 > 1) {
            let v2 = *0x1::vector::borrow<u8>(&arg0.coefficients, v0 - 1);
            0x1::vector::push_back<u8>(&mut v1, v2);
            let v3 = 1;
            let v4 = v0 - 2;
            if (v3 > v4) {
            } else {
                loop {
                    let v5 = 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::gf256::sub(*0x1::vector::borrow<u8>(&arg0.coefficients, v0 - v3 - 1), 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::gf256::mul(v2, arg1));
                    v2 = v5;
                    0x1::vector::push_back<u8>(&mut v1, v5);
                    if (v3 >= v4) {
                        break
                    };
                    v3 = v3 + 1;
                };
            };
            0x1::vector::reverse<u8>(&mut v1);
        };
        Polynomial{coefficients: v1}
    }

    public fun evaluate(arg0: &Polynomial, arg1: u8) : u8 {
        if (0x1::vector::is_empty<u8>(&arg0.coefficients)) {
            return 0
        };
        let v0 = 0x1::vector::length<u8>(&arg0.coefficients);
        let v1 = *0x1::vector::borrow<u8>(&arg0.coefficients, v0 - 1);
        let v2 = 0;
        while (v2 < v0 - 1) {
            let v3 = 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::gf256::mul(v1, arg1);
            v1 = 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::gf256::add(v3, *0x1::vector::borrow<u8>(&arg0.coefficients, v0 - v2 - 2));
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun get_constant_term(arg0: &Polynomial) : u8 {
        if (0x1::vector::is_empty<u8>(&arg0.coefficients)) {
            0
        } else {
            *0x1::vector::borrow<u8>(&arg0.coefficients, 0)
        }
    }

    public(friend) fun interpolate_all(arg0: &vector<u8>, arg1: &vector<vector<u8>>) : vector<Polynomial> {
        assert!(0x1::vector::length<u8>(arg0) == 0x1::vector::length<vector<u8>>(arg1), 1);
        let v0 = 0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(arg1, 0));
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<vector<u8>>(arg1)) {
            if (!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(arg1, v1)) == v0)) {
                v2 = false;
                /* label 7 */
                assert!(v2, 1);
                let v3 = compute_numerators(*arg0);
                let v4 = 0x1::vector::empty<Polynomial>();
                let v5 = 0;
                while (v5 < v0) {
                    let v6 = b"";
                    let v7 = 0;
                    while (v7 < 0x1::vector::length<vector<u8>>(arg1)) {
                        0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(0x1::vector::borrow<vector<u8>>(arg1, v7), v5));
                        v7 = v7 + 1;
                    };
                    0x1::vector::push_back<Polynomial>(&mut v4, interpolate_with_numerators(arg0, &v6, &v3));
                    v5 = v5 + 1;
                };
                return v4
            };
            v1 = v1 + 1;
        };
        v2 = true;
        /* goto 7 */
    }

    fun interpolate_with_numerators(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<Polynomial>) : Polynomial {
        assert!(0x1::vector::length<u8>(arg0) == 0x1::vector::length<u8>(arg1), 1);
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = Polynomial{coefficients: b""};
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 1;
            let v4 = 0;
            while (v4 < v0) {
                if (v4 != v2) {
                    v3 = 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::gf256::mul(v3, 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::gf256::sub(*0x1::vector::borrow<u8>(arg0, v2), *0x1::vector::borrow<u8>(arg0, v4)));
                };
                v4 = v4 + 1;
            };
            let v5 = &v1;
            let v6 = scale(0x1::vector::borrow<Polynomial>(arg2, v2), 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::gf256::div(*0x1::vector::borrow<u8>(arg1, v2), v3));
            v1 = add(v5, &v6);
            v2 = v2 + 1;
        };
        v1
    }

    fun monic_linear(arg0: &u8) : Polynomial {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, *arg0);
        0x1::vector::push_back<u8>(v1, 1);
        Polynomial{coefficients: v0}
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

