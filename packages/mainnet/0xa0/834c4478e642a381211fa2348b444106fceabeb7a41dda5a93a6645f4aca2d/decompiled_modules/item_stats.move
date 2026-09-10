module 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats {
    struct ItemStatistics has copy, drop, store {
        vitality: u16,
        wisdom: u16,
        strength: u16,
        intelligence: u16,
        chance: u16,
        agility: u16,
        range: u16,
        movement: u16,
        action: u16,
        critical: u16,
        raw_damage: u16,
        earth_resistance: u16,
        fire_resistance: u16,
        water_resistance: u16,
        air_resistance: u16,
    }

    public fun action(arg0: &ItemStatistics) : u16 {
        arg0.action
    }

    public fun agility(arg0: &ItemStatistics) : u16 {
        arg0.agility
    }

    public fun air_resistance(arg0: &ItemStatistics) : u16 {
        arg0.air_resistance
    }

    public fun apply_centered_to_base(arg0: u64, arg1: u64) : u64 {
        let v0 = (32768 as u64);
        if (arg1 >= v0) {
            arg0 + arg1 - v0
        } else {
            let v2 = v0 - arg1;
            if (v2 >= arg0) {
                1
            } else {
                arg0 - v2
            }
        }
    }

    public fun chance(arg0: &ItemStatistics) : u16 {
        arg0.chance
    }

    public fun critical(arg0: &ItemStatistics) : u16 {
        arg0.critical
    }

    public fun earth_resistance(arg0: &ItemStatistics) : u16 {
        arg0.earth_resistance
    }

    public fun fire_resistance(arg0: &ItemStatistics) : u16 {
        arg0.fire_resistance
    }

    public fun fold(arg0: &vector<ItemStatistics>) : ItemStatistics {
        let v0 = (32768 as u64);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 15) {
            let v3 = 0;
            let v4 = 0;
            let v5 = 0;
            while (v5 < 0x1::vector::length<ItemStatistics>(arg0)) {
                let v6 = to_vector(0x1::vector::borrow<ItemStatistics>(arg0, v5));
                let v7 = (*0x1::vector::borrow<u16>(&v6, v2) as u64);
                if (v7 >= v0) {
                    v3 = v3 + v7 - v0;
                } else {
                    v4 = v4 + v0 - v7;
                };
                v5 = v5 + 1;
            };
            let v8 = if (v3 >= v4) {
                let v9 = v0 + v3 - v4;
                if (v9 > 65535) {
                    65535
                } else {
                    v9
                }
            } else {
                let v10 = v4 - v3;
                if (v10 >= v0) {
                    0
                } else {
                    v0 - v10
                }
            };
            0x1::vector::push_back<u16>(&mut v1, (v8 as u16));
            v2 = v2 + 1;
        };
        from_vector(v1)
    }

    public fun from_vector(arg0: vector<u16>) : ItemStatistics {
        ItemStatistics{
            vitality         : *0x1::vector::borrow<u16>(&arg0, 0),
            wisdom           : *0x1::vector::borrow<u16>(&arg0, 1),
            strength         : *0x1::vector::borrow<u16>(&arg0, 2),
            intelligence     : *0x1::vector::borrow<u16>(&arg0, 3),
            chance           : *0x1::vector::borrow<u16>(&arg0, 4),
            agility          : *0x1::vector::borrow<u16>(&arg0, 5),
            range            : *0x1::vector::borrow<u16>(&arg0, 6),
            movement         : *0x1::vector::borrow<u16>(&arg0, 7),
            action           : *0x1::vector::borrow<u16>(&arg0, 8),
            critical         : *0x1::vector::borrow<u16>(&arg0, 9),
            raw_damage       : *0x1::vector::borrow<u16>(&arg0, 10),
            earth_resistance : *0x1::vector::borrow<u16>(&arg0, 11),
            fire_resistance  : *0x1::vector::borrow<u16>(&arg0, 12),
            water_resistance : *0x1::vector::borrow<u16>(&arg0, 13),
            air_resistance   : *0x1::vector::borrow<u16>(&arg0, 14),
        }
    }

    public fun intelligence(arg0: &ItemStatistics) : u16 {
        arg0.intelligence
    }

    public fun movement(arg0: &ItemStatistics) : u16 {
        arg0.movement
    }

    public fun new(arg0: u16, arg1: u16, arg2: u16, arg3: u16, arg4: u16, arg5: u16, arg6: u16, arg7: u16, arg8: u16, arg9: u16, arg10: u16, arg11: u16, arg12: u16, arg13: u16, arg14: u16) : ItemStatistics {
        ItemStatistics{
            vitality         : arg0,
            wisdom           : arg1,
            strength         : arg2,
            intelligence     : arg3,
            chance           : arg4,
            agility          : arg5,
            range            : arg6,
            movement         : arg7,
            action           : arg8,
            critical         : arg9,
            raw_damage       : arg10,
            earth_resistance : arg11,
            fire_resistance  : arg12,
            water_resistance : arg13,
            air_resistance   : arg14,
        }
    }

    public fun range(arg0: &ItemStatistics) : u16 {
        arg0.range
    }

    public fun raw_damage(arg0: &ItemStatistics) : u16 {
        arg0.raw_damage
    }

    public fun scale_from_center(arg0: &ItemStatistics, arg1: u64, arg2: u64) : ItemStatistics {
        let v0 = 32768;
        let v1 = vector[];
        let v2 = to_vector(arg0);
        0x1::vector::reverse<u16>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u16>(&v2)) {
            let v4 = 0x1::vector::pop_back<u16>(&mut v2);
            let v5 = if (v4 >= v0) {
                v0 + ((((v4 - v0) as u64) * arg1 / arg2) as u16)
            } else {
                v0 - ((((v0 - v4) as u64) * arg1 / arg2) as u16)
            };
            0x1::vector::push_back<u16>(&mut v1, v5);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<u16>(v2);
        from_vector(v1)
    }

    public fun shift() : u16 {
        32768
    }

    public fun strength(arg0: &ItemStatistics) : u16 {
        arg0.strength
    }

    public fun to_raw(arg0: &ItemStatistics) : vector<u64> {
        let v0 = to_vector(arg0);
        let v1 = (32768 as u64);
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 0x1::vector::length<u16>(&v0)) {
            let v4 = (*0x1::vector::borrow<u16>(&v0, v3) as u64);
            let v5 = if (v4 >= v1) {
                v4 - v1
            } else {
                0
            };
            0x1::vector::push_back<u64>(&mut v2, v5);
            v3 = v3 + 1;
        };
        v2
    }

    public fun to_vector(arg0: &ItemStatistics) : vector<u16> {
        let v0 = 0x1::vector::empty<u16>();
        let v1 = &mut v0;
        0x1::vector::push_back<u16>(v1, arg0.vitality);
        0x1::vector::push_back<u16>(v1, arg0.wisdom);
        0x1::vector::push_back<u16>(v1, arg0.strength);
        0x1::vector::push_back<u16>(v1, arg0.intelligence);
        0x1::vector::push_back<u16>(v1, arg0.chance);
        0x1::vector::push_back<u16>(v1, arg0.agility);
        0x1::vector::push_back<u16>(v1, arg0.range);
        0x1::vector::push_back<u16>(v1, arg0.movement);
        0x1::vector::push_back<u16>(v1, arg0.action);
        0x1::vector::push_back<u16>(v1, arg0.critical);
        0x1::vector::push_back<u16>(v1, arg0.raw_damage);
        0x1::vector::push_back<u16>(v1, arg0.earth_resistance);
        0x1::vector::push_back<u16>(v1, arg0.fire_resistance);
        0x1::vector::push_back<u16>(v1, arg0.water_resistance);
        0x1::vector::push_back<u16>(v1, arg0.air_resistance);
        v0
    }

    public fun vitality(arg0: &ItemStatistics) : u16 {
        arg0.vitality
    }

    public fun water_resistance(arg0: &ItemStatistics) : u16 {
        arg0.water_resistance
    }

    public fun wisdom(arg0: &ItemStatistics) : u16 {
        arg0.wisdom
    }

    public fun zero() : ItemStatistics {
        let v0 = 0x1::vector::empty<u16>();
        let v1 = &mut v0;
        0x1::vector::push_back<u16>(v1, 32768);
        0x1::vector::push_back<u16>(v1, 32768);
        0x1::vector::push_back<u16>(v1, 32768);
        0x1::vector::push_back<u16>(v1, 32768);
        0x1::vector::push_back<u16>(v1, 32768);
        0x1::vector::push_back<u16>(v1, 32768);
        0x1::vector::push_back<u16>(v1, 32768);
        0x1::vector::push_back<u16>(v1, 32768);
        0x1::vector::push_back<u16>(v1, 32768);
        0x1::vector::push_back<u16>(v1, 32768);
        0x1::vector::push_back<u16>(v1, 32768);
        0x1::vector::push_back<u16>(v1, 32768);
        0x1::vector::push_back<u16>(v1, 32768);
        0x1::vector::push_back<u16>(v1, 32768);
        0x1::vector::push_back<u16>(v1, 32768);
        from_vector(v0)
    }

    // decompiled from Move bytecode v7
}

