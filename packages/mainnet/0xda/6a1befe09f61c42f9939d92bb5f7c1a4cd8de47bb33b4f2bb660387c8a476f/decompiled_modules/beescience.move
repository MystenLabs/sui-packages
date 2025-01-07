module 0xda6a1befe09f61c42f9939d92bb5f7c1a4cd8de47bb33b4f2bb660387c8a476f::beescience {
    public fun breed_bees(arg0: u256, arg1: u256, arg2: u256, arg3: u256) : u256 {
        0 | slice_number(arg0, 4, 0) | 0 << 4 | mix_appearance_traits(arg0, arg1, arg2) | mix_capability_traits(arg0, arg1, arg3)
    }

    public fun calculate_pow(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : u128 {
        let v0 = (arg0 as u256) * (1000000000000000000 as u256) / (arg1 as u256);
        let v1 = (arg2 as u256) * (1000000000000000000 as u256) / (arg3 as u256);
        if (v1 == 0) {
            return (1000000000000000000 as u128)
        };
        if (v0 == 0) {
            return (v0 as u128)
        };
        let v2 = v1 / (1000000000000000000 as u256);
        let v3 = v1 % (1000000000000000000 as u256);
        let v4 = v0;
        if (v2 == 0) {
            v4 = (1000000000000000000 as u256);
        } else {
            let v5 = 1;
            while (v5 < (v2 as u128)) {
                let v6 = v4 * v0;
                v4 = v6 / (1000000000000000000 as u256);
                v5 = v5 + 1;
            };
        };
        if (v3 == 0) {
            return (v4 as u128)
        };
        ((v4 * pow_approx_frac(v0, (v3 as u128), 1000000000000000) / (1000000000000000000 as u256)) as u128)
    }

    public entry fun compute_gene_price(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg0 + arg1 * ((pow_approx((arg2 as u128), 2, 3) / (1000000000000 as u128)) as u64)
    }

    public fun decode_appearance_traits(arg0: u256) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 28) {
            0x1::vector::push_back<u8>(&mut v0, (slice_number(arg0, 5, 4 + 3 + v1 * 5) as u8));
            v1 = v1 + 1;
        };
        v0
    }

    public fun decode_dominant_appearance_traits(arg0: u256) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 7) {
            0x1::vector::push_back<u8>(&mut v0, (slice_number(arg0, 5, 4 + 3 + v1 * 20) as u8));
            v1 = v1 + 1;
        };
        v0
    }

    public fun decode_dominant_power_traits(arg0: u256) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 7) {
            0x1::vector::push_back<u8>(&mut v0, (slice_number(arg0, 4, 147 + v1 * 12) as u8));
            v1 = v1 + 1;
        };
        v0
    }

    public fun decode_power_traits(arg0: u256) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 21) {
            0x1::vector::push_back<u8>(&mut v0, (slice_number(arg0, 4, 147 + (v1 as u8) * 4) as u8));
            v1 = v1 + 1;
        };
        v0
    }

    public fun encode_appearance_traits(arg0: vector<u8>) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 28) {
            v0 = v0 | (*0x1::vector::borrow<u8>(&arg0, v1) as u256) << 4 + 3 + (v1 as u8) * 5;
            v1 = v1 + 1;
        };
        v0
    }

    public fun encode_power_traits(arg0: vector<u8>) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 21) {
            v0 = v0 | (*0x1::vector::borrow<u8>(&arg0, v1) as u256) << 147 + (v1 as u8) * 4;
            v1 = v1 + 1;
        };
        v0
    }

    public fun enhance_trait(arg0: u8, arg1: u8, arg2: u8) : u8 {
        let v0 = 0x1::u8::max(arg0, arg1);
        let v1 = 0x1::u8::min(arg0, arg1);
        if (arg2 < 3 && v0 < 31) {
            v0 + 1
        } else if (arg2 < 6 && v1 < v0) {
            v1 + 1
        } else {
            v0
        }
    }

    public fun evolution_chance(arg0: u8) : u8 {
        if (arg0 == 0) {
            50
        } else if (arg0 == 1) {
            70
        } else if (arg0 == 2) {
            90
        } else if (arg0 == 3) {
            110
        } else if (arg0 == 4) {
            90
        } else if (arg0 == 5) {
            70
        } else if (arg0 == 6) {
            50
        } else {
            30
        }
    }

    public fun evolve_appearance_trait(arg0: u8, arg1: u8, arg2: u8) : u8 {
        let v0 = if (arg1 == 8 - 1) {
            31
        } else {
            23 + arg1
        };
        if (arg0 >= v0) {
            return arg0
        };
        if (arg2 < 192) {
            arg0 + 1
        } else if (arg2 < 224 && arg0 < v0 - 1) {
            arg0 + 2
        } else if (arg2 < 244 && arg0 > 0) {
            arg0 - 1
        } else if (arg2 < 248 && arg0 < v0 - 2) {
            arg0 + 3
        } else {
            arg0
        }
    }

    public fun evolve_appearance_traits(arg0: u256, arg1: u8, arg2: &vector<u256>) : u256 {
        let v0 = arg0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 28) {
            if (v2 > 230) {
                v1 = v1 + 1;
                v2 = 0;
            };
            let v4 = 4 + 3 + v3 * 5;
            let v5 = *0x1::vector::borrow<u256>(arg2, v1 % 0x1::vector::length<u256>(arg2));
            let v6 = if ((slice_number(v5, 8, v2) as u8) < evolution_chance(arg1)) {
                evolve_appearance_trait((slice_number(arg0, 5, v4) as u8), arg1, (slice_number(v5, 8, v2 + 8) as u8))
            } else {
                (slice_number(arg0, 5, v4) as u8)
            };
            let v7 = v0 & 115792089237316195423570985008687907853269984665640564039457584007913129639935 - ((1 << 5) - 1 << v4);
            v0 = v7 | (v6 as u256) << v4;
            v2 = v2 + 16;
            v3 = v3 + 1;
        };
        v0
    }

    public fun evolve_bee(arg0: u256, arg1: vector<u256>) : u256 {
        let v0 = (0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::min_u64((((slice_number(arg0, 3, 4) as u8) + 1) as u64), ((8 - 1) as u64)) as u8);
        evolve_power_traits(evolve_appearance_traits(arg0 & 115792089237316195423570985008687907853269984665640564039457584007913129639935 - (7 << 4) | (v0 as u256) << 4, v0, &arg1), v0, &arg1)
    }

    public fun evolve_power_trait(arg0: u8, arg1: u8, arg2: u8) : u8 {
        let v0 = if (arg1 == 8 - 1) {
            15
        } else {
            9 + arg1
        };
        if (arg0 >= v0) {
            return arg0
        };
        if (arg2 < 192) {
            arg0 + 1
        } else if (arg2 < 224 && arg0 < v0 - 1) {
            arg0 + 2
        } else if (arg2 < 244 && arg0 > 0) {
            arg0 - 1
        } else if (arg2 < 248 && arg0 < v0 - 2) {
            arg0 + 3
        } else {
            arg0
        }
    }

    public fun evolve_power_traits(arg0: u256, arg1: u8, arg2: &vector<u256>) : u256 {
        let v0 = arg0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 21) {
            if (v2 > 230) {
                v1 = v1 + 1;
                v2 = 0;
            };
            let v4 = 147 + v3 * 4;
            let v5 = *0x1::vector::borrow<u256>(arg2, v1 % 0x1::vector::length<u256>(arg2));
            let v6 = if ((slice_number(v5, 8, v2) as u8) < evolution_chance(arg1)) {
                evolve_power_trait((slice_number(arg0, 4, v4) as u8), arg1, (slice_number(v5, 8, v2 + 8) as u8))
            } else {
                (slice_number(arg0, 4, v4) as u8)
            };
            let v7 = v0 & 115792089237316195423570985008687907853269984665640564039457584007913129639935 - ((1 << 4) - 1 << v4);
            v0 = v7 | (v6 as u256) << v4;
            v2 = v2 + 16;
            v3 = v3 + 1;
        };
        v0
    }

    public fun get_4_bits(arg0: u256, arg1: u8) : u8 {
        (slice_number(arg0, 4, arg1 * 4) as u8)
    }

    public fun get_5_bits(arg0: u256, arg1: u8) : u8 {
        (slice_number(arg0, 5, arg1 * 5) as u8)
    }

    public fun get_evolution_stage(arg0: u256) : u8 {
        (slice_number(arg0, 3, 4) as u8)
    }

    public fun get_family_type(arg0: u256) : u8 {
        (slice_number(arg0, 4, 0) as u8)
    }

    public fun mix_appearance_traits(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 28) {
            let v3 = (slice_number(arg2, 2, v1) as u8);
            let v4 = v1 + 2;
            let v5 = if (v3 == 0) {
                if (slice_number(arg2, 1, v4) == 0) {
                    (slice_number(arg0, 5, 4 + 3 + v2 * 5) as u8)
                } else {
                    (slice_number(arg1, 5, 4 + 3 + v2 * 5) as u8)
                }
            } else if (v3 == 1) {
                (((((slice_number(arg0, 5, 4 + 3 + v2 * 5) as u8) as u64) + ((slice_number(arg1, 5, 4 + 3 + v2 * 5) as u8) as u64)) / 2) as u8)
            } else if (v3 == 2) {
                enhance_trait((slice_number(arg0, 5, 4 + 3 + v2 * 5) as u8), (slice_number(arg1, 5, 4 + 3 + v2 * 5) as u8), (slice_number(arg2, 4, v4) as u8))
            } else {
                mutate_trait(0x1::u8::max((slice_number(arg0, 5, 4 + 3 + v2 * 5) as u8), (slice_number(arg1, 5, 4 + 3 + v2 * 5) as u8)), (slice_number(arg2, 4, v4) as u8))
            };
            v1 = v4 + 2;
            v0 = v0 | (v5 as u256) << 4 + 3 + v2 * 5;
            v2 = v2 + 1;
        };
        v0
    }

    public fun mix_capability_traits(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 21) {
            let v3 = (slice_number(arg2, 2, v1) as u8);
            let v4 = v1 + 2;
            let v5 = if (v3 == 0) {
                0x1::u8::max((slice_number(arg0, 4, 147 + (v2 as u8) * 4) as u8), (slice_number(arg1, 4, 147 + (v2 as u8) * 4) as u8))
            } else if (v3 == 1) {
                enhance_trait((slice_number(arg0, 4, 147 + (v2 as u8) * 4) as u8), (slice_number(arg1, 4, 147 + (v2 as u8) * 4) as u8), (slice_number(arg2, 4, v4) as u8))
            } else {
                synergy_boost((slice_number(arg0, 4, 147 + (v2 as u8) * 4) as u8), (slice_number(arg1, 4, 147 + (v2 as u8) * 4) as u8), (slice_number(arg2, 4, v4) as u8))
            };
            v1 = v4 + 2;
            v0 = v0 | (v5 as u256) << 147 + v2 * 4;
            v2 = v2 + 1;
        };
        v0
    }

    public fun mutate_trait(arg0: u8, arg1: u8) : u8 {
        if (arg1 == 0) {
            ((arg1 << 1) as u8)
        } else if (arg1 < 3 && arg0 > 0) {
            arg0 - 1
        } else if (arg1 < 5 && arg0 < 31) {
            arg0 + 1
        } else {
            arg0
        }
    }

    public fun pow_approx(arg0: u128, arg1: u128, arg2: u128) : u128 {
        let v0 = 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::constants::precision_constant();
        if (arg0 <= 2) {
            return calculate_pow(arg0, 1, arg1, arg2)
        };
        let v1 = 0;
        while (arg0 >= 2) {
            arg0 = arg0 / 2;
            v1 = v1 + 1;
        };
        let v2 = arg0 * (v0 as u128);
        let v3 = 0;
        while (v3 < v1) {
            v2 = v2 / 2;
            v3 = v3 + 1;
        };
        calculate_pow(2, 1, v1 * arg1, arg2) / (v0 as u128) * calculate_pow(v2, (v0 as u128), arg1, arg2)
    }

    public fun pow_approx_frac(arg0: u256, arg1: u128, arg2: u64) : u256 {
        let (v0, v1) = sub_sign(arg0, (1000000000000000000 as u256));
        let v2 = (1000000000000000000 as u256);
        let v3 = v2;
        let v4 = false;
        let v5 = 0;
        let v6 = 1;
        while (v2 >= (arg2 as u256) && v6 < 32) {
            let (v7, v8) = sub_sign((arg1 as u256), v5);
            let v9 = ((v6 * (1000000000000000000 as u128)) as u256);
            v5 = v9;
            let v10 = v2 * v7 / (1000000000000000000 as u256) * v0 / v9;
            v2 = v10;
            if (v10 == 0) {
                break
            };
            if (v1) {
                v4 = !v4;
            };
            if (v8) {
                v4 = !v4;
            };
            if (v4) {
                v3 = v3 - v10;
            } else {
                v3 = v3 + v10;
            };
            v6 = v6 + 1;
        };
        v3
    }

    public fun slice_number(arg0: u256, arg1: u8, arg2: u8) : u256 {
        arg0 >> arg2 & (1 << arg1) - 1
    }

    fun sub_sign(arg0: u256, arg1: u256) : (u256, bool) {
        if (arg0 >= arg1) {
            return (arg0 - arg1, false)
        };
        (arg1 - arg0, true)
    }

    public fun synergy_boost(arg0: u8, arg1: u8, arg2: u8) : u8 {
        let v0 = 0x1::u8::max(arg0, arg1);
        let v1 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        let v2 = if (v1 <= 2) {
            if (arg2 < 4) {
                v0 < 15
            } else {
                false
            }
        } else {
            false
        };
        if (v2) {
            v0 + 1
        } else {
            v0
        }
    }

    // decompiled from Move bytecode v6
}

