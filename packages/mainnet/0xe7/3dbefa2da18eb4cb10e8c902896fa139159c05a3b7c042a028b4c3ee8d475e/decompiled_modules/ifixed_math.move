module 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::ifixed_math {
    fun atom_scale(arg0: u64) : u256 {
        0x1::u256::pow(10, ((18 - arg0) as u8))
    }

    public(friend) fun fixed_to_u64_down(arg0: u256, arg1: u64) : (u64, bool) {
        to_u64(arg0 / atom_scale(arg1))
    }

    public(friend) fun fixed_to_u64_up(arg0: u256, arg1: u64) : (u64, bool) {
        to_u64(0x1::u256::div_ceil(arg0, atom_scale(arg1)))
    }

    public(friend) fun nonnegative_rate(arg0: u256) : u256 {
        if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg0)) {
            0
        } else {
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(arg0)
        }
    }

    public(friend) fun to_u64(arg0: u256) : (u64, bool) {
        if (arg0 > 18446744073709551615) {
            (0, false)
        } else {
            ((arg0 as u64), true)
        }
    }

    public(friend) fun usd_fixed_to_collateral_fixed(arg0: u256, arg1: u256, arg2: bool) : (u256, bool) {
        if (arg1 == 0) {
            return (0, false)
        };
        let v0 = 1000000000000000000;
        let v1 = 0x1::u256::checked_mul(arg0 / arg1, v0);
        if (0x1::option::is_some<u256>(&v1)) {
            let v2 = 0x1::u256::checked_mul(arg0 % arg1, v0);
            if (0x1::option::is_some<u256>(&v2)) {
                let v3 = 0x1::option::destroy_some<u256>(v2);
                let v4 = 0x1::u256::checked_add(0x1::option::destroy_some<u256>(v1), v3 / arg1);
                if (0x1::option::is_some<u256>(&v4)) {
                    let v5 = 0x1::option::destroy_some<u256>(v4);
                    if (!arg2 || v3 % arg1 == 0) {
                        return (v5, true)
                    };
                    return if (v5 == 115792089237316195423570985008687907853269984665640564039457584007913129639935) {
                        (0, false)
                    } else {
                        (v5 + 1, true)
                    }
                };
                0x1::option::destroy_none<u256>(v4);
                return (0, false)
            };
            0x1::option::destroy_none<u256>(v2);
            return (0, false)
        };
        0x1::option::destroy_none<u256>(v1);
        (0, false)
    }

    // decompiled from Move bytecode v7
}

