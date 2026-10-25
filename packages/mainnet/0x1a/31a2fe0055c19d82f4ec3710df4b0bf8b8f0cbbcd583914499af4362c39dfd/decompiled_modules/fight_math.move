module 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::fight_math {
    public fun amplify_damage(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg0 * (100 + arg1) / 100 + arg2
    }

    public fun apply_centered_resistance(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 >= arg2) {
            apply_resistance(arg0, arg1 - arg2)
        } else {
            arg0 * (100 + arg2 - arg1) / 100
        }
    }

    public fun apply_centered_shift(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg0 + arg1;
        if (v0 > arg2) {
            v0 - arg2
        } else {
            0
        }
    }

    public fun apply_resistance(arg0: u64, arg1: u64) : u64 {
        let v0 = if (arg1 > 50) {
            50
        } else {
            arg1
        };
        arg0 * (100 - v0) / 100
    }

    public fun band_scaled(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg2 == arg1) {
            return arg0
        };
        let v0 = arg2 - arg1;
        arg0 * (6 * v0 + 10 * (arg3 - arg1)) / 10 * v0
    }

    public fun centered_band_scaled(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        if (arg0 >= arg1) {
            arg1 + band_scaled(arg0 - arg1, arg2, arg3, arg4)
        } else {
            let v1 = if (arg3 == arg2) {
                arg1 - arg0
            } else {
                let v2 = arg3 - arg2;
                (arg1 - arg0) * (16 * v2 - 10 * (arg4 - arg2)) / 10 * v2
            };
            if (v1 >= arg1) {
                0
            } else {
                arg1 - v1
            }
        }
    }

    public fun crit_at(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        if (arg1 == 0) {
            return false
        };
        arg0 % crit_denominator(arg1, arg2, arg3) == 0
    }

    public fun crit_denominator(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 <= 2) {
            return arg0
        };
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        };
        if (v0 < 2) {
            return 2
        };
        let v1 = v0 * 29901 * 1000000 / 10000 * ln_e6(arg2 + 12);
        let v2 = if (v1 < v0) {
            v1
        } else {
            v0
        };
        if (v2 < 2) {
            2
        } else {
            v2
        }
    }

    public fun effect_seed(arg0: u64, arg1: u64) : u64 {
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::mix(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::mix(arg0, arg1), 982727)
    }

    public fun heal_amount(arg0: u64, arg1: u64) : u64 {
        arg0 * (100 + arg1) / 100
    }

    public fun ln_e6(arg0: u64) : u64 {
        log2_e6(arg0) * 693147 / 1000000
    }

    fun log2_e6(arg0: u64) : u64 {
        let v0 = 1000000;
        let v1 = 0;
        while (arg0 >= 2) {
            arg0 = arg0 / 2;
            v1 = v1 + 1;
        };
        let v2 = v1 * v0;
        let v3 = arg0 * v0 / pow2(v1);
        let v4 = v0 / 2;
        while (v4 > 0) {
            v3 = v3 * v3 / v0;
            if (v3 >= 2 * v0) {
                v3 = v3 / 2;
                v2 = v2 + v4;
            };
            v4 = v4 / 2;
        };
        v2
    }

    public fun max_1(arg0: u64) : u64 {
        if (arg0 == 0) {
            1
        } else {
            arg0
        }
    }

    public fun mob_loot_chance_scaled(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg2 == arg1) {
            return arg0
        };
        let v0 = arg2 - arg1;
        let v1 = arg0 * (8 * v0 + 4 * (arg3 - arg1)) / 10 * v0;
        if (v1 > 10000) {
            10000
        } else {
            v1
        }
    }

    public fun mob_pool_scaled(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg2 == arg1) {
            return arg0
        };
        let v0 = arg2 - arg1;
        let v1 = 10 * v0;
        (arg0 * (10 * v0 + 3 * (arg3 - arg1)) + v1 / 2) / v1
    }

    fun pow2(arg0: u64) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 2;
            v1 = v1 + 1;
        };
        v0
    }

    public fun primary_stat(arg0: &0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        if (*arg0 == 0x1::string::utf8(b"earth")) {
            arg1
        } else if (*arg0 == 0x1::string::utf8(b"fire")) {
            arg2
        } else if (*arg0 == 0x1::string::utf8(b"water")) {
            arg3
        } else if (*arg0 == 0x1::string::utf8(b"air")) {
            arg4
        } else {
            0
        }
    }

    public fun punishment_base(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            return arg0
        };
        let v0 = if (arg1 > arg2) {
            arg2
        } else {
            arg1
        };
        arg0 * (2 * arg2 - v0) / arg2
    }

    public fun push_collision_damage(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        (400 + (arg2 % 8 + 1) * arg0) * arg1 / 50
    }

    public fun remove_points(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : (u64, u64) {
        if (!arg2) {
            let v0 = if (arg1 < arg5) {
                arg1
            } else {
                arg5
            };
            return (arg0, v0)
        };
        if (arg6 == 0) {
            return (arg0, 0)
        };
        let v1 = arg3 / 10;
        let v2 = if (v1 < 1) {
            1
        } else {
            v1
        };
        let v3 = arg4 / 10;
        let v4 = if (v3 < 1) {
            1
        } else {
            v3
        };
        let v5 = 0;
        while (v5 < arg1 && v5 < arg5) {
            let v6 = 50 * v2 / v4 * (arg5 - v5) / arg6;
            let v7 = if (v6 < 10) {
                10
            } else if (v6 > 90) {
                90
            } else {
                v6
            };
            if (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::draw(&mut arg0) % 100 < v7) {
                v5 = v5 + 1;
            } else {
                break
            };
        };
        (arg0, v5)
    }

    public fun resist(arg0: u64, arg1: u64, arg2: u64) : u64 {
        apply_centered_resistance(arg0, arg1, arg2)
    }

    public fun resolved_damage(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        resist(amplify_damage(arg0, arg1, arg2), arg3, arg4)
    }

    public fun retro_group_coefficient_tenths(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = vector[10, 11, 15, 23, 31, 36];
        let v1 = 0x1::vector::length<u64>(&v0) - 1;
        let v2 = if (arg0 - 1 < v1) {
            arg0 - 1
        } else {
            v1
        };
        *0x1::vector::borrow<u64>(&v0, v2)
    }

    public fun roll_effect_value(arg0: &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::Effect, arg1: &mut u64) : u64 {
        let v0 = (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::value(arg0) as u64);
        let v1 = (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::value_max(arg0) as u64);
        if (v1 <= v0) {
            return v0
        };
        roll_in_range(v0, v1, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::draw(arg1) % 10000)
    }

    public fun roll_in_range(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 <= arg0) {
            return arg0
        };
        arg0 + arg2 * (arg1 - arg0 + 1) / 10000
    }

    public fun sat_sub(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    public fun spell_crit_roll(arg0: u64, arg1: &0x1::string::String) : u64 {
        let v0 = 0x1::string::as_bytes(arg1);
        let v1 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::mix(arg0, 0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v0)) {
            v1 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::mix(v1, (*0x1::vector::borrow<u8>(v0, v2) as u64));
            v2 = v2 + 1;
        };
        v1
    }

    public fun tackle_bucket(arg0: u64) : u64 {
        arg0 / 10 + 2
    }

    public fun tackle_contest(arg0: u64, arg1: &vector<u64>) : (u64, u64) {
        let v0 = tackle_bucket(arg0);
        let v1 = 1;
        let v2 = 1;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(arg1)) {
            let v4 = 2 * tackle_bucket(*0x1::vector::borrow<u64>(arg1, v3));
            let v5 = if (v0 < v4) {
                v0
            } else {
                v4
            };
            v1 = v1 * v5;
            v2 = v2 * v4;
            v3 = v3 + 1;
        };
        (v1, v2)
    }

    public fun tackle_losses(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        let v0 = arg3 - arg2;
        ((arg0 * v0 + arg3 - 1) / arg3, (arg1 * v0 + arg3 - 1) / arg3)
    }

    public fun tackle_seed(arg0: u64, arg1: u64) : u64 {
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::mix(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::mix(arg0, arg1), 502814)
    }

    public fun weave_teams(arg0: vector<u8>) : vector<u64> {
        let v0 = vector[];
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&arg0)) {
            if (*0x1::vector::borrow<u8>(&arg0, v2) == 0) {
                0x1::vector::push_back<u64>(&mut v0, v2);
            } else {
                0x1::vector::push_back<u64>(&mut v1, v2);
            };
            v2 = v2 + 1;
        };
        let v3 = 0x1::vector::length<u64>(&v0);
        let v4 = 0x1::vector::length<u64>(&v1);
        let v5 = vector[];
        let v6 = 0;
        let v7 = 0;
        while (v6 < v3 || v7 < v4) {
            if (v6 >= v3 && false || v7 >= v4 || (v3 - v6) * v4 >= (v4 - v7) * v3) {
                0x1::vector::push_back<u64>(&mut v5, *0x1::vector::borrow<u64>(&v0, v6));
                v6 = v6 + 1;
                continue
            };
            0x1::vector::push_back<u64>(&mut v5, *0x1::vector::borrow<u64>(&v1, v7));
            v7 = v7 + 1;
        };
        v5
    }

    public fun xp_for_player(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else if (arg3 == 0) {
            true
        } else if (arg4 == 0) {
            true
        } else if (arg5 == 0) {
            true
        } else {
            arg6 == 0
        };
        if (v0) {
            return 0
        };
        let v1 = arg0 * retro_group_coefficient_tenths(arg6) / 10;
        let v2 = v1;
        if (arg4 > arg3 + 10) {
            v2 = v1 * (arg3 + 10) / arg4;
        };
        if (arg3 > arg4 + 5) {
            let v3 = v2 * arg4;
            v2 = v3 / arg3;
        };
        if (arg3 * 2 > arg5 * 5) {
            let v4 = v2 * arg5 * 5;
            v2 = v4 / arg3 * 2;
        };
        v2 * arg2 / arg3 * (100 + arg1) / 100
    }

    // decompiled from Move bytecode v7
}

