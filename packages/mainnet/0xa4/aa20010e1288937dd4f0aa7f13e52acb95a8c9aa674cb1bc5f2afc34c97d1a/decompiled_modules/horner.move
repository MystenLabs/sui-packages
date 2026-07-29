module 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::horner {
    struct SignedScaled256 has copy, drop {
        mag: u256,
        neg: bool,
    }

    public(friend) fun add(arg0: SignedScaled256, arg1: SignedScaled256) : SignedScaled256 {
        if (arg0.mag == 0) {
            return arg1
        };
        if (arg1.mag == 0) {
            return arg0
        };
        if (arg0.neg == arg1.neg) {
            SignedScaled256{mag: arg0.mag + arg1.mag, neg: arg0.neg}
        } else if (arg0.mag > arg1.mag) {
            SignedScaled256{mag: arg0.mag - arg1.mag, neg: arg0.neg}
        } else if (arg1.mag > arg0.mag) {
            SignedScaled256{mag: arg1.mag - arg0.mag, neg: arg1.neg}
        } else {
            zero()
        }
    }

    public(friend) fun add_coeff(arg0: SignedScaled256, arg1: u128, arg2: bool) : SignedScaled256 {
        let v0 = (arg1 as u256);
        if (v0 == 0) {
            return arg0
        };
        if (arg0.mag == 0) {
            return SignedScaled256{
                mag : v0,
                neg : arg2,
            }
        };
        if (arg0.neg == arg2) {
            SignedScaled256{mag: arg0.mag + v0, neg: arg0.neg}
        } else if (arg0.mag > v0) {
            SignedScaled256{mag: arg0.mag - v0, neg: arg0.neg}
        } else if (v0 > arg0.mag) {
            SignedScaled256{mag: v0 - arg0.mag, neg: arg2}
        } else {
            zero()
        }
    }

    public(friend) fun assert_polynomial_nonempty(arg0: u64) {
        assert!(arg0 > 0, 13835058794016538625);
    }

    public(friend) fun eval_rational(arg0: u128, arg1: vector<u128>, arg2: vector<bool>, arg3: vector<u128>, arg4: vector<bool>, arg5: u256) : u256 {
        eval_rational_scaled((arg0 as u256) * arg5 / 1000000000, arg1, arg2, arg3, arg4, arg5)
    }

    public(friend) fun eval_rational_scaled(arg0: u256, arg1: vector<u128>, arg2: vector<bool>, arg3: vector<u128>, arg4: vector<bool>, arg5: u256) : u256 {
        let v0 = from_unsigned(arg0);
        let v1 = 0x1::vector::length<u128>(&arg1);
        assert_polynomial_nonempty(v1);
        let v2 = v1 - 1;
        let v3 = from_coeff(*0x1::vector::borrow<u128>(&arg1, v2), *0x1::vector::borrow<bool>(&arg2, v2));
        let v4 = v2;
        while (v4 > 0) {
            v4 = v4 - 1;
            let v5 = mul_wad(v3, v0, arg5);
            v3 = add_coeff(v5, *0x1::vector::borrow<u128>(&arg1, v4), *0x1::vector::borrow<bool>(&arg2, v4));
        };
        let v6 = v3;
        let v7 = 0x1::vector::length<u128>(&arg3);
        assert_polynomial_nonempty(v7);
        let v8 = v7 - 1;
        let v9 = from_coeff(*0x1::vector::borrow<u128>(&arg3, v8), *0x1::vector::borrow<bool>(&arg4, v8));
        let v10 = v8;
        while (v10 > 0) {
            v10 = v10 - 1;
            let v11 = mul_wad(v9, v0, arg5);
            v9 = add_coeff(v11, *0x1::vector::borrow<u128>(&arg3, v10), *0x1::vector::borrow<bool>(&arg4, v10));
        };
        let v12 = v9;
        assert!(!is_neg(&v6), 13835340934713311235);
        assert!(!is_neg(&v12) && mag(&v12) > 0, 13835622413985120261);
        0x1::option::destroy_some<u256>(0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u256::mul_div(mag(&v6), 1000000000, mag(&v12), 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::nearest()))
    }

    public(friend) fun from_coeff(arg0: u128, arg1: bool) : SignedScaled256 {
        let v0 = (arg0 as u256);
        let v1 = v0 != 0 && arg1;
        SignedScaled256{
            mag : v0,
            neg : v1,
        }
    }

    public(friend) fun from_unsigned(arg0: u256) : SignedScaled256 {
        SignedScaled256{
            mag : arg0,
            neg : false,
        }
    }

    public(friend) fun is_neg(arg0: &SignedScaled256) : bool {
        arg0.neg
    }

    public(friend) fun mag(arg0: &SignedScaled256) : u256 {
        arg0.mag
    }

    public(friend) fun mul_wad(arg0: SignedScaled256, arg1: SignedScaled256, arg2: u256) : SignedScaled256 {
        let v0 = arg0.mag * arg1.mag / arg2;
        let v1 = v0 != 0 && arg0.neg != arg1.neg;
        SignedScaled256{
            mag : v0,
            neg : v1,
        }
    }

    public(friend) fun zero() : SignedScaled256 {
        SignedScaled256{
            mag : 0,
            neg : false,
        }
    }

    // decompiled from Move bytecode v7
}

