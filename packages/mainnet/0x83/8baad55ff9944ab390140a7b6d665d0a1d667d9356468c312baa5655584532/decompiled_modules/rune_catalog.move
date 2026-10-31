module 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog {
    public fun has_rune(arg0: u8, arg1: u8) : bool {
        assert!((arg0 as u64) < 15, 1);
        if (arg1 < 1 || arg1 > 3) {
            return false
        };
        let v0 = tier_amount_vec(arg1);
        *0x1::vector::borrow<u64>(&v0, (arg0 as u64)) != 0
    }

    public fun max_tier(arg0: u8) : u8 {
        assert!((arg0 as u64) < 15, 1);
        let v0 = vector[30, 10, 10, 10, 10, 10, 0, 0, 0, 0, 0, 10, 10, 10, 10];
        if (*0x1::vector::borrow<u64>(&v0, (arg0 as u64)) > 0) {
            3
        } else {
            1
        }
    }

    public fun rune_amount(arg0: u8, arg1: u8) : u64 {
        assert!(has_rune(arg0, arg1), 2);
        let v0 = tier_amount_vec(arg1);
        *0x1::vector::borrow<u64>(&v0, (arg0 as u64))
    }

    public fun rune_weight(arg0: u8, arg1: u8) : u64 {
        (rune_amount(arg0, arg1) * stat_unit_weight(arg0) + 20 - 1) / 20 * 20
    }

    public fun slug(arg0: u8, arg1: u8) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"rune_");
        0x1::string::append(&mut v0, stat_slug(arg0));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"_"));
        0x1::string::append(&mut v0, tier_slug(arg1));
        v0
    }

    public fun stat_count() : u64 {
        15
    }

    fun stat_slug(arg0: u8) : 0x1::string::String {
        let v0 = vector[b"vitality", b"wisdom", b"strength", b"intelligence", b"chance", b"agility", b"range", b"movement", b"action", b"critical", b"raw_damage", b"earth_resistance", b"fire_resistance", b"water_resistance", b"air_resistance"];
        0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v0, (arg0 as u64)))
    }

    public fun stat_unit_weight(arg0: u8) : u64 {
        assert!((arg0 as u64) < 15, 1);
        let v0 = vector[5, 60, 20, 20, 20, 20, 1020, 1800, 2000, 600, 400, 80, 80, 80, 80];
        *0x1::vector::borrow<u64>(&v0, (arg0 as u64))
    }

    fun tier_amount_vec(arg0: u8) : vector<u64> {
        if (arg0 == 1) {
            vector[3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
        } else if (arg0 == 2) {
            vector[10, 3, 3, 3, 3, 3, 0, 0, 0, 0, 0, 3, 3, 3, 3]
        } else {
            vector[30, 10, 10, 10, 10, 10, 0, 0, 0, 0, 0, 10, 10, 10, 10]
        }
    }

    public fun tier_ba() : u8 {
        1
    }

    public fun tier_pa() : u8 {
        2
    }

    public fun tier_ra() : u8 {
        3
    }

    fun tier_slug(arg0: u8) : 0x1::string::String {
        if (arg0 == 1) {
            0x1::string::utf8(b"ba")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"pa")
        } else {
            0x1::string::utf8(b"ra")
        }
    }

    public fun weight_scale() : u64 {
        20
    }

    // decompiled from Move bytecode v7
}

