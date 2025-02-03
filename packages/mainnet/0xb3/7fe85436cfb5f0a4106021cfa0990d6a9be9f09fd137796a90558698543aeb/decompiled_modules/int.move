module 0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::int {
    struct Int has copy, drop, store {
        value: u256,
    }

    public fun abs(arg0: Int) : Int {
        if (is_neg(arg0)) {
            from_u256((arg0.value ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935) + 1)
        } else {
            arg0
        }
    }

    public fun add(arg0: Int, arg1: Int) : Int {
        if (is_positive(arg0)) {
            if (is_positive(arg1)) {
                from_u256(arg0.value + arg1.value)
            } else {
                let v1 = abs(arg1);
                if (arg0.value >= v1.value) {
                    return from_u256(arg0.value - v1.value)
                };
                return neg_from_u256(v1.value - arg0.value)
            }
        } else {
            if (is_positive(arg1)) {
                let v2 = abs(arg0);
                if (arg1.value >= v2.value) {
                    return from_u256(arg1.value - v2.value)
                };
                return neg_from_u256(v2.value - arg1.value)
            };
            let v3 = abs(arg0);
            let v4 = abs(arg1);
            neg_from_u256(v3.value + v4.value)
        }
    }

    public fun and(arg0: Int, arg1: Int) : Int {
        Int{value: arg0.value & arg1.value}
    }

    public fun compare(arg0: Int, arg1: Int) : u8 {
        if (arg0.value == arg1.value) {
            return 0
        };
        if (is_positive(arg0)) {
            if (is_positive(arg1)) {
                return if (arg0.value > arg1.value) {
                    2
                } else {
                    1
                }
            };
            return 2
        };
        if (is_positive(arg1)) {
            return 1
        };
        let v1 = abs(arg0);
        let v2 = abs(arg1);
        if (v1.value > v2.value) {
            1
        } else {
            2
        }
    }

    public fun div_down(arg0: Int, arg1: Int) : Int {
        if (is_positive(arg0)) {
            if (is_positive(arg1)) {
                return from_u256(0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::math256::div_down(arg0.value, arg1.value))
            };
            let v0 = abs(arg1);
            return neg_from_u256(0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::math256::div_down(arg0.value, v0.value))
        };
        if (is_positive(arg1)) {
            let v1 = abs(arg0);
            return neg_from_u256(0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::math256::div_down(v1.value, arg1.value))
        };
        let v2 = abs(arg0);
        let v3 = abs(arg1);
        from_u256(0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::math256::div_down(v2.value, v3.value))
    }

    public fun div_up(arg0: Int, arg1: Int) : Int {
        if (is_positive(arg0)) {
            if (is_positive(arg1)) {
                return from_u256(0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::math256::div_up(arg0.value, arg1.value))
            };
            let v0 = abs(arg1);
            return neg_from_u256(0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::math256::div_up(arg0.value, v0.value))
        };
        if (is_positive(arg1)) {
            let v1 = abs(arg0);
            return neg_from_u256(0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::math256::div_up(v1.value, arg1.value))
        };
        let v2 = abs(arg0);
        let v3 = abs(arg1);
        from_u256(0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::math256::div_up(v2.value, v3.value))
    }

    public fun eq(arg0: Int, arg1: Int) : bool {
        compare(arg0, arg1) == 0
    }

    public fun flip(arg0: Int) : Int {
        if (is_neg(arg0)) {
            abs(arg0)
        } else {
            neg_from_u256(arg0.value)
        }
    }

    public fun from_u128(arg0: u128) : Int {
        Int{value: (arg0 as u256)}
    }

    public fun from_u16(arg0: u16) : Int {
        Int{value: (arg0 as u256)}
    }

    public fun from_u256(arg0: u256) : Int {
        assert!(arg0 <= 57896044618658097711785492504343953926634992332820282019728792003956564819967, 0);
        Int{value: arg0}
    }

    public fun from_u32(arg0: u32) : Int {
        Int{value: (arg0 as u256)}
    }

    public fun from_u64(arg0: u64) : Int {
        Int{value: (arg0 as u256)}
    }

    public fun from_u8(arg0: u8) : Int {
        Int{value: (arg0 as u256)}
    }

    public fun gt(arg0: Int, arg1: Int) : bool {
        compare(arg0, arg1) == 2
    }

    public fun gte(arg0: Int, arg1: Int) : bool {
        let v0 = compare(arg0, arg1);
        v0 == 2 || v0 == 0
    }

    public fun is_neg(arg0: Int) : bool {
        arg0.value & 57896044618658097711785492504343953926634992332820282019728792003956564819968 != 0
    }

    public fun is_positive(arg0: Int) : bool {
        57896044618658097711785492504343953926634992332820282019728792003956564819968 > arg0.value
    }

    public fun is_zero(arg0: Int) : bool {
        arg0.value == 0
    }

    public fun lt(arg0: Int, arg1: Int) : bool {
        compare(arg0, arg1) == 1
    }

    public fun lte(arg0: Int, arg1: Int) : bool {
        let v0 = compare(arg0, arg1);
        v0 == 1 || v0 == 0
    }

    public fun max() : Int {
        Int{value: 57896044618658097711785492504343953926634992332820282019728792003956564819967}
    }

    public fun mod(arg0: Int, arg1: Int) : Int {
        let v0 = abs(arg0);
        let v1 = abs(arg1);
        let v2 = v0.value % v1.value;
        if (is_neg(arg0) && v2 != 0) {
            neg_from_u256(v2)
        } else {
            from_u256(v2)
        }
    }

    public fun mul(arg0: Int, arg1: Int) : Int {
        if (is_positive(arg0)) {
            if (is_positive(arg1)) {
                return from_u256(arg0.value * arg1.value)
            };
            let v0 = abs(arg1);
            return neg_from_u256(arg0.value * v0.value)
        };
        if (is_positive(arg1)) {
            let v1 = abs(arg0);
            return neg_from_u256(v1.value * arg1.value)
        };
        let v2 = abs(arg0);
        let v3 = abs(arg1);
        from_u256(v2.value * v3.value)
    }

    public fun neg_from_u128(arg0: u128) : Int {
        let v0 = from_u128(arg0);
        if (v0.value > 0) {
            v0.value = 115792089237316195423570985008687907853269984665640564039457584007913129639935 - v0.value + 1;
        };
        v0
    }

    public fun neg_from_u16(arg0: u16) : Int {
        let v0 = from_u16(arg0);
        if (v0.value > 0) {
            v0.value = 115792089237316195423570985008687907853269984665640564039457584007913129639935 - v0.value + 1;
        };
        v0
    }

    public fun neg_from_u256(arg0: u256) : Int {
        let v0 = from_u256(arg0);
        if (v0.value > 0) {
            v0.value = 115792089237316195423570985008687907853269984665640564039457584007913129639935 - v0.value + 1;
        };
        v0
    }

    public fun neg_from_u32(arg0: u32) : Int {
        let v0 = from_u32(arg0);
        if (v0.value > 0) {
            v0.value = 115792089237316195423570985008687907853269984665640564039457584007913129639935 - v0.value + 1;
        };
        v0
    }

    public fun neg_from_u64(arg0: u64) : Int {
        let v0 = from_u64(arg0);
        if (v0.value > 0) {
            v0.value = 115792089237316195423570985008687907853269984665640564039457584007913129639935 - v0.value + 1;
        };
        v0
    }

    public fun neg_from_u8(arg0: u8) : Int {
        let v0 = from_u8(arg0);
        if (v0.value > 0) {
            v0.value = 115792089237316195423570985008687907853269984665640564039457584007913129639935 - v0.value + 1;
        };
        v0
    }

    public fun one() : Int {
        Int{value: 1}
    }

    public fun or(arg0: Int, arg1: Int) : Int {
        Int{value: arg0.value | arg1.value}
    }

    public fun pow(arg0: Int, arg1: u256) : Int {
        let v0 = abs(arg0);
        let v1 = 0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::math256::pow(v0.value, arg1);
        assert!(v1 <= 57896044618658097711785492504343953926634992332820282019728792003956564819967, 0);
        let v2 = Int{value: v1};
        if (is_neg(arg0) && arg1 % 2 != 0) {
            flip(v2)
        } else {
            v2
        }
    }

    public fun shl(arg0: Int, arg1: u8) : Int {
        Int{value: arg0.value << arg1}
    }

    public fun shr(arg0: Int, arg1: u8) : Int {
        let v0 = if (is_positive(arg0)) {
            arg0.value >> arg1
        } else {
            arg0.value >> arg1 | 57896044618658097711785492504343953926634992332820282019728792003956564819967 << ((256 - (arg1 as u16)) as u8)
        };
        Int{value: v0}
    }

    public fun sub(arg0: Int, arg1: Int) : Int {
        if (is_positive(arg0)) {
            if (is_positive(arg1)) {
                if (arg0.value >= arg1.value) {
                    return from_u256(arg0.value - arg1.value)
                };
                return neg_from_u256(arg1.value - arg0.value)
            };
            let v0 = abs(arg1);
            return from_u256(arg0.value + v0.value)
        };
        if (is_positive(arg1)) {
            let v1 = abs(arg0);
            return neg_from_u256(v1.value + arg1.value)
        };
        let v2 = abs(arg0);
        let v3 = abs(arg1);
        if (v3.value >= v2.value) {
            return from_u256(v3.value - v2.value)
        };
        neg_from_u256(v2.value - v3.value)
    }

    public fun to_u128(arg0: Int) : u128 {
        assert!(is_positive(arg0), 1);
        (arg0.value as u128)
    }

    public fun to_u16(arg0: Int) : u16 {
        assert!(is_positive(arg0), 1);
        (arg0.value as u16)
    }

    public fun to_u256(arg0: Int) : u256 {
        assert!(is_positive(arg0), 1);
        arg0.value
    }

    public fun to_u32(arg0: Int) : u32 {
        assert!(is_positive(arg0), 1);
        (arg0.value as u32)
    }

    public fun to_u64(arg0: Int) : u64 {
        assert!(is_positive(arg0), 1);
        (arg0.value as u64)
    }

    public fun to_u8(arg0: Int) : u8 {
        assert!(is_positive(arg0), 1);
        (arg0.value as u8)
    }

    public fun truncate_to_u128(arg0: Int) : u128 {
        ((arg0.value & 340282366920938463463374607431768211455) as u128)
    }

    public fun truncate_to_u16(arg0: Int) : u16 {
        ((arg0.value & 65535) as u16)
    }

    public fun truncate_to_u32(arg0: Int) : u32 {
        ((arg0.value & 4294967295) as u32)
    }

    public fun truncate_to_u64(arg0: Int) : u64 {
        ((arg0.value & 18446744073709551615) as u64)
    }

    public fun truncate_to_u8(arg0: Int) : u8 {
        ((arg0.value & 255) as u8)
    }

    public fun value(arg0: Int) : u256 {
        arg0.value
    }

    public(friend) fun wrap(arg0: Int, arg1: u256) : u256 {
        let v0 = from_u256(arg1);
        let v1 = if (is_neg(arg0)) {
            add(arg0, v0)
        } else {
            sub(arg0, mul(v0, div_down(arg0, v0)))
        };
        to_u256(v1)
    }

    public fun zero() : Int {
        Int{value: 0}
    }

    // decompiled from Move bytecode v6
}

