module 0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::water {
    public fun azure() : u8 {
        1
    }

    public fun base_rarity(arg0: u8, arg1: u8, arg2: u8) : u8 {
        let (_, v1, _) = sort3(arg0, arg1, arg2);
        v1
    }

    public fun cap_of(arg0: u8) : u64 {
        let v0 = caps();
        *0x1::vector::borrow<u64>(&v0, (arg0 as u64))
    }

    public fun caps() : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, 1100);
        0x1::vector::push_back<u64>(v1, 600);
        0x1::vector::push_back<u64>(v1, 330);
        0x1::vector::push_back<u64>(v1, 150);
        0x1::vector::push_back<u64>(v1, 40);
        0x1::vector::push_back<u64>(v1, 2);
        v0
    }

    public fun clear() : u8 {
        0
    }

    public fun count_bits(arg0: u8) : u8 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 5) {
            if (arg0 & 1 << v1 != 0) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun emerald() : u8 {
        2
    }

    public fun fresh_weight(arg0: u8) : u64 {
        purity_of(arg0) * 100
    }

    public fun fusion_weight(arg0: u64, arg1: u8, arg2: bool) : u64 {
        if (arg2) {
            arg0 * 110 / 100 + purity_of(arg1) * 100
        } else {
            arg0 * 110 / 100
        }
    }

    public fun gold() : u8 {
        4
    }

    public fun max_tier() : u8 {
        6
    }

    public fun n_rarities() : u64 {
        6
    }

    public fun n_traits() : u8 {
        5
    }

    public fun nth_set_bit(arg0: u8, arg1: u8) : u8 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = v2;
        while (v1 < 5) {
            let v4 = 1 << v1;
            if (arg0 & v4 != 0) {
                if (v0 == arg1 && v2 == 0) {
                    v3 = v4;
                };
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v3
    }

    public fun prism() : u8 {
        5
    }

    public fun purity_of(arg0: u8) : u64 {
        let v0 = vector[1, 2, 4, 8, 16, 32];
        *0x1::vector::borrow<u64>(&v0, (arg0 as u64))
    }

    public fun rarest(arg0: u8, arg1: u8, arg2: u8) : u8 {
        let (_, _, v2) = sort3(arg0, arg1, arg2);
        v2
    }

    public fun rarity_name(arg0: u8) : vector<u8> {
        if (arg0 == 0) {
            b"Clear"
        } else if (arg0 == 1) {
            b"Azure"
        } else if (arg0 == 2) {
            b"Emerald"
        } else if (arg0 == 3) {
            b"Violet"
        } else if (arg0 == 4) {
            b"Gold"
        } else {
            b"Prism"
        }
    }

    public fun resolve_rarity(arg0: u8, arg1: u8, arg2: u8, arg3: bool) : u8 {
        let v0 = base_rarity(arg0, arg1, arg2);
        let v1 = rarest(arg0, arg1, arg2);
        let v2 = v0;
        if (arg3 && v0 < 5) {
            v2 = v0 + 1;
        };
        let v3 = if (v1 == 0) {
            0
        } else {
            v1 - 1
        };
        if (v2 < v3) {
            v2 = v3;
        };
        v2
    }

    public fun sort3(arg0: u8, arg1: u8, arg2: u8) : (u8, u8, u8) {
        let (v0, v1) = if (arg0 <= arg1) {
            (arg0, arg1)
        } else {
            (arg1, arg0)
        };
        let (v2, v3) = if (v1 <= arg2) {
            (v1, arg2)
        } else {
            (arg2, v1)
        };
        let (v4, v5) = if (v0 <= v2) {
            (v0, v2)
        } else {
            (v2, v0)
        };
        (v4, v5, v3)
    }

    public fun tier_name(arg0: u8) : vector<u8> {
        if (arg0 == 1) {
            b"Droplet"
        } else if (arg0 == 2) {
            b"Puddle"
        } else if (arg0 == 3) {
            b"Pond"
        } else if (arg0 == 4) {
            b"Lake"
        } else if (arg0 == 5) {
            b"Sea"
        } else {
            b"Ocean"
        }
    }

    public fun trait_name(arg0: u8) : vector<u8> {
        if (arg0 == 1) {
            b"Bubbles"
        } else if (arg0 == 2) {
            b"Reflection"
        } else if (arg0 == 4) {
            b"Sparkles"
        } else if (arg0 == 8) {
            b"Ripple"
        } else if (arg0 == 16) {
            b"Moonlight"
        } else {
            b"Still"
        }
    }

    public fun units_of_tier(arg0: u8) : u64 {
        let v0 = 1;
        let v1 = 1;
        while (v1 < arg0) {
            v0 = v0 * 3;
            v1 = v1 + 1;
        };
        v0
    }

    public fun upgrade_pct(arg0: u8, arg1: bool) : u8 {
        let v0 = x"0a0a0f19283c";
        if (arg1) {
            *0x1::vector::borrow<u8>(&v0, (arg0 as u64)) * 2
        } else {
            *0x1::vector::borrow<u8>(&v0, (arg0 as u64))
        }
    }

    public fun violet() : u8 {
        3
    }

    // decompiled from Move bytecode v7
}

