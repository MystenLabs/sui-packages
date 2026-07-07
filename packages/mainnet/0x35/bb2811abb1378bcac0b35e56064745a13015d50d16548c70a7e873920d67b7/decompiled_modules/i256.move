module 0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::i256 {
    struct I256 has copy, drop, store {
        pos0: u256,
    }

    fun abs_unchecked(arg0: I256) : u256 {
        if (is_positive(arg0)) {
            arg0.pos0
        } else {
            not_u256(arg0.pos0 - 1)
        }
    }

    public(friend) fun add(arg0: I256, arg1: I256) : I256 {
        let v0 = wrapping_add(arg0, arg1);
        let v1 = sign(arg0) == sign(arg1) && sign(arg0) != sign(v0);
        assert!(!v1, 13835058454714318852);
        v0
    }

    fun compare(arg0: I256, arg1: I256) : u8 {
        if (arg0.pos0 == arg1.pos0) {
            return 1
        };
        let v0 = is_negative(arg0);
        if (v0 != is_negative(arg1)) {
            if (v0) {
                0
            } else {
                2
            }
        } else if (arg0.pos0 > arg1.pos0) {
            2
        } else {
            0
        }
    }

    public(friend) fun div(arg0: I256, arg1: I256) : I256 {
        assert!(arg1.pos0 != 0, 13835621503452250120);
        if (is_positive(arg0) != is_positive(arg1)) {
            negative_from_u256(abs_unchecked(arg0) / abs_unchecked(arg1))
        } else {
            from_u256(abs_unchecked(arg0) / abs_unchecked(arg1))
        }
    }

    public(friend) fun exp(arg0: I256) : I256 {
        if (lte(arg0, negative_from_u256(42139678854452767551))) {
            return zero()
        };
        assert!(lt(arg0, from_u256(135305999368893231589)), 13835058703822422020);
        let v0 = div(shl(arg0, 78), from_u256(3814697265625));
        let v1 = shr(add(div(shl(v0, 96), from_u256(54916777467707473351141471128)), from_u256(39614081257132168796771975168)), 96);
        let v2 = sub(v0, mul(v1, from_u256(54916777467707473351141471128)));
        let v3 = add(shr(mul(add(v2, from_u256(1346386616545796478920950773328)), v2), 96), from_u256(57155421227552351082224309758442));
        let v4 = sub(from_u8(195), v1);
        if (to_u256(v4) > 255) {
            return zero()
        };
        from_u256(to_u256(div(add(mul(add(shr(mul(sub(add(v3, v2), from_u256(94201549194550492254356042504812)), v3), 96), from_u256(28719021644029726153956944680412240)), v2), from_u256(347437083999162433888837515002539729507623920905942392673140736)), add(shr(mul(sub(shr(mul(add(shr(mul(sub(shr(mul(add(shr(mul(sub(v2, from_u256(2855989394907223263936484059900)), v2), 96), from_u256(50020603652535783019961831881945)), v2), 96), from_u256(533845033583426703283633433725380)), v2), 96), from_u256(3604857256930695427073651918091429)), v2), 96), from_u256(14423608567350463180887372962807573)), v2), 96), from_u256(26449188498355588339934803723976023)))) * 3822833074963236453042738258902158003155416615667 >> to_u8(v4))
    }

    public(friend) fun from_u256(arg0: u256) : I256 {
        assert!(57896044618658097711785492504343953926634992332820282019728792003956564819967 >= arg0, 13835058222786084868);
        I256{pos0: arg0}
    }

    public(friend) fun from_u8(arg0: u8) : I256 {
        I256{pos0: (arg0 as u256)}
    }

    public(friend) fun gt(arg0: I256, arg1: I256) : bool {
        compare(arg0, arg1) == 2
    }

    public(friend) fun is_negative(arg0: I256) : bool {
        arg0.pos0 & 57896044618658097711785492504343953926634992332820282019728792003956564819968 != 0
    }

    public(friend) fun is_positive(arg0: I256) : bool {
        57896044618658097711785492504343953926634992332820282019728792003956564819968 > arg0.pos0
    }

    public(friend) fun is_zero(arg0: I256) : bool {
        arg0.pos0 == 0
    }

    public(friend) fun lt(arg0: I256, arg1: I256) : bool {
        compare(arg0, arg1) == 0
    }

    public(friend) fun lte(arg0: I256, arg1: I256) : bool {
        compare(arg0, arg1) != 2
    }

    public(friend) fun mul(arg0: I256, arg1: I256) : I256 {
        if (arg0.pos0 == 0 || arg1.pos0 == 0) {
            return zero()
        };
        let v0 = abs_unchecked(arg0);
        let v1 = abs_unchecked(arg1);
        let v2 = is_positive(arg0) != is_positive(arg1);
        let v3 = if (v2) {
            57896044618658097711785492504343953926634992332820282019728792003956564819968
        } else {
            57896044618658097711785492504343953926634992332820282019728792003956564819967
        };
        assert!(v0 <= v3 / v1, 13835058523433795588);
        if (v2) {
            negative_from_u256(v0 * v1)
        } else {
            from_u256(v0 * v1)
        }
    }

    public(friend) fun negative_from_u256(arg0: u256) : I256 {
        if (arg0 == 0) {
            return zero()
        };
        assert!(57896044618658097711785492504343953926634992332820282019728792003956564819968 >= arg0, 13835339723532730374);
        I256{pos0: not_u256(arg0) + 1 | 57896044618658097711785492504343953926634992332820282019728792003956564819968}
    }

    fun not_u256(arg0: u256) : u256 {
        arg0 ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935
    }

    public(friend) fun shl(arg0: I256, arg1: u8) : I256 {
        I256{pos0: arg0.pos0 << arg1}
    }

    public(friend) fun shr(arg0: I256, arg1: u8) : I256 {
        if (arg1 == 0) {
            return arg0
        };
        if (is_positive(arg0)) {
            I256{pos0: arg0.pos0 >> arg1}
        } else {
            I256{pos0: arg0.pos0 >> arg1 | 115792089237316195423570985008687907853269984665640564039457584007913129639935 << ((256 - (arg1 as u16)) as u8)}
        }
    }

    fun sign(arg0: I256) : u8 {
        ((arg0.pos0 >> 255) as u8)
    }

    public(friend) fun sub(arg0: I256, arg1: I256) : I256 {
        let v0 = wrapping_sub(arg0, arg1);
        let v1 = sign(arg0) != sign(arg1) && sign(arg0) != sign(v0);
        assert!(!v1, 13835058480484122628);
        v0
    }

    public(friend) fun to_u256(arg0: I256) : u256 {
        assert!(is_positive(arg0), 13835339770777370630);
        arg0.pos0
    }

    public(friend) fun to_u8(arg0: I256) : u8 {
        (arg0.pos0 as u8)
    }

    public(friend) fun wad_div_trunc(arg0: I256, arg1: I256) : I256 {
        div(mul(arg0, from_u256(1000000000000000000)), arg1)
    }

    public(friend) fun wad_mul_trunc(arg0: I256, arg1: I256) : I256 {
        div(mul(arg0, arg1), from_u256(1000000000000000000))
    }

    fun wrapping_add(arg0: I256, arg1: I256) : I256 {
        let v0 = if (arg0.pos0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg1.pos0) {
            arg0.pos0 - 115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg1.pos0 - 1
        } else {
            arg0.pos0 + arg1.pos0
        };
        I256{pos0: v0}
    }

    fun wrapping_sub(arg0: I256, arg1: I256) : I256 {
        let v0 = I256{pos0: not_u256(arg1.pos0)};
        wrapping_add(arg0, wrapping_add(v0, from_u256(1)))
    }

    public(friend) fun zero() : I256 {
        I256{pos0: 0}
    }

    // decompiled from Move bytecode v7
}

