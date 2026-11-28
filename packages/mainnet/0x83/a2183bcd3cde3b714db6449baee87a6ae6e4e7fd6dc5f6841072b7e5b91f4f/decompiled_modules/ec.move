module 0x83a2183bcd3cde3b714db6449baee87a6ae6e4e7fd6dc5f6841072b7e5b91f4f::ec {
    struct Curve has copy, drop, store {
        p: u256,
        a: u256,
        b: u256,
    }

    struct Point has copy, drop, store {
        x: u256,
        y: u256,
        z: u256,
    }

    public fun add(arg0: Curve, arg1: Point, arg2: Point) : Point {
        if (0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::is_zero(arg1.z, arg0.p)) {
            return arg2
        };
        if (0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::is_zero(arg2.z, arg0.p)) {
            return arg1
        };
        let v0 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg1.z, arg1.z, arg0.p);
        let v1 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg2.z, arg2.z, arg0.p);
        let v2 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg1.x, v1, arg0.p);
        let v3 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg2.x, v0, arg0.p);
        if (v2 == v3) {
            if (0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg1.y, 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg2.z, v1, arg0.p), arg0.p) == 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg2.y, 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg1.z, v0, arg0.p), arg0.p)) {
                return double(arg0, arg1)
            };
            return infinity()
        };
        add_core(arg0, v2, v3, 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg1.y, 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg2.z, v1, arg0.p), arg0.p), 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg2.y, 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg1.z, v0, arg0.p), arg0.p), arg1.z, arg2.z)
    }

    fun add_core(arg0: Curve, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256) : Point {
        let v0 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::sub(arg2, arg1, arg0.p);
        let v1 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::sub(arg4, arg3, arg0.p);
        let v2 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(v0, v0, arg0.p);
        let v3 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(v0, v2, arg0.p);
        let v4 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg1, v2, arg0.p);
        let v5 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::sub(0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::sub(0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(v1, v1, arg0.p), v3, arg0.p), 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::add(v4, v4, arg0.p), arg0.p);
        Point{
            x : v5,
            y : 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::sub(0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(v1, 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::sub(v4, v5, arg0.p), arg0.p), 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg3, v3, arg0.p), arg0.p),
            z : 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(v0, 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg5, arg6, arg0.p), arg0.p),
        }
    }

    public fun bn254() : Curve {
        Curve{
            p : 21888242871839275222246405745257275088696311157297823662689037894645226208583,
            a : 0,
            b : 3,
        }
    }

    public fun coeff_a(arg0: Curve) : u256 {
        arg0.a
    }

    public fun coeff_b(arg0: Curve) : u256 {
        arg0.b
    }

    public fun double(arg0: Curve, arg1: Point) : Point {
        let v0 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg1.x, arg1.x, arg0.p);
        let v1 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg1.y, arg1.y, arg0.p);
        let v2 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(v1, v1, arg0.p);
        let v3 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg1.x, v1, arg0.p);
        let v4 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::add(v3, v3, arg0.p);
        let v5 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::add(v4, v4, arg0.p);
        let v6 = if (0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::is_zero(arg0.a, arg0.p)) {
            0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::add(0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::add(v0, v0, arg0.p), v0, arg0.p)
        } else {
            let v7 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg1.z, arg1.z, arg0.p);
            0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::add(0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::add(0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::add(v0, v0, arg0.p), v0, arg0.p), 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg0.a, 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(v7, v7, arg0.p), arg0.p), arg0.p)
        };
        let v8 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::sub(0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(v6, v6, arg0.p), 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::add(v5, v5, arg0.p), arg0.p);
        let v9 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::add(v2, v2, arg0.p);
        let v10 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::add(v9, v9, arg0.p);
        let v11 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg1.y, arg1.z, arg0.p);
        Point{
            x : v8,
            y : 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::sub(0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(v6, 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::sub(v5, v8, arg0.p), arg0.p), 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::add(v10, v10, arg0.p), arg0.p),
            z : 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::add(v11, v11, arg0.p),
        }
    }

    public fun eq(arg0: Curve, arg1: Point, arg2: Point) : bool {
        let v0 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::is_zero(arg1.z, arg0.p);
        let v1 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::is_zero(arg2.z, arg0.p);
        if (v0 || v1) {
            return v0 && v1
        };
        let v2 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg1.z, arg1.z, arg0.p);
        let v3 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg2.z, arg2.z, arg0.p);
        0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg1.x, v3, arg0.p) == 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg2.x, v2, arg0.p) && 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg1.y, 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg2.z, v3, arg0.p), arg0.p) == 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg2.y, 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg1.z, v2, arg0.p), arg0.p)
    }

    public fun from_affine(arg0: Curve, arg1: u256, arg2: u256) : Point {
        assert!(arg1 < arg0.p, 2);
        assert!(arg2 < arg0.p, 2);
        assert!(is_on_curve(arg0, arg1, arg2), 5);
        Point{
            x : arg1,
            y : arg2,
            z : 1,
        }
    }

    public fun generator_bn254() : Point {
        Point{
            x : 1,
            y : 2,
            z : 1,
        }
    }

    public fun generator_secp256k1() : Point {
        Point{
            x : 55066263022277343669578718895168534326250603453777594175500187360389116729240,
            y : 32670510020758816978083085130507043184471273380659243275938904335757337482424,
            z : 1,
        }
    }

    public fun infinity() : Point {
        Point{
            x : 1,
            y : 1,
            z : 0,
        }
    }

    public fun is_infinity(arg0: Curve, arg1: Point) : bool {
        0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::is_zero(arg1.z, arg0.p)
    }

    public fun is_on_curve(arg0: Curve, arg1: u256, arg2: u256) : bool {
        0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg2, arg2, arg0.p) == 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::add(0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::add(0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg1, arg1, arg0.p), arg1, arg0.p), 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg0.a, arg1, arg0.p), arg0.p), arg0.b, arg0.p)
    }

    public fun modulus(arg0: Curve) : u256 {
        arg0.p
    }

    public fun neg(arg0: Curve, arg1: Point) : Point {
        Point{
            x : arg1.x,
            y : 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::neg(arg1.y, arg0.p),
            z : arg1.z,
        }
    }

    public fun new_curve(arg0: u256, arg1: u256, arg2: u256) : Curve {
        assert!(arg0 > 3, 1);
        assert!(arg0 & 1 == 1, 1);
        assert!(arg1 < arg0, 2);
        assert!(arg2 < arg0, 2);
        let v0 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg1, arg1, arg0), arg1, arg0);
        let v1 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::add(v0, v0, arg0);
        assert!(0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::add(0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::add(v1, v1, arg0), 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(27, 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg2, arg2, arg0), arg0), arg0) != 0, 3);
        Curve{
            p : arg0,
            a : arg1,
            b : arg2,
        }
    }

    public fun order_bn254() : u256 {
        21888242871839275222246405745257275088548364400416034343698204186575808495617
    }

    public fun order_secp256k1() : u256 {
        115792089237316195423570985008687907852837564279074904382605163141518161494337
    }

    public fun scalar_mul(arg0: Curve, arg1: u256, arg2: Point) : Point {
        let v0 = infinity();
        let v1 = arg1;
        while (v1 > 0) {
            if (v1 & 1 == 1) {
                v0 = add(arg0, v0, arg2);
            };
            v1 = v1 >> 1;
            if (v1 > 0) {
                arg2 = double(arg0, arg2);
            };
        };
        v0
    }

    public fun scalar_mul_ladder(arg0: Curve, arg1: u256, arg2: Point) : Point {
        let v0 = infinity();
        let v1 = arg2;
        let v2 = 256;
        while (v2 > 0) {
            v2 = v2 - 1;
            if (arg1 >> (v2 as u8) & 1 == 1) {
                v0 = add(arg0, v0, v1);
                v1 = double(arg0, v1);
                continue
            };
            v1 = add(arg0, v0, v1);
            v0 = double(arg0, v0);
        };
        v0
    }

    public fun secp256k1() : Curve {
        Curve{
            p : 115792089237316195423570985008687907853269984665640564039457584007908834671663,
            a : 0,
            b : 7,
        }
    }

    public fun sub(arg0: Curve, arg1: Point, arg2: Point) : Point {
        add(arg0, arg1, neg(arg0, arg2))
    }

    public fun to_affine(arg0: Curve, arg1: Point) : (u256, u256) {
        assert!(!0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::is_zero(arg1.z, arg0.p), 4);
        let v0 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::inv(arg1.z, arg0.p);
        let v1 = 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(v0, v0, arg0.p);
        (0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg1.x, v1, arg0.p), 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(arg1.y, 0x8bed1477e8d557e5e667bb743dc817ea82d54e2742d3ff20eddba13e924349ac::field::mul(v1, v0, arg0.p), arg0.p))
    }

    // decompiled from Move bytecode v7
}

