module 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::job_xp {
    public fun craft_required_level(arg0: u64) : u64 {
        if (arg0 <= 2) {
            return 1
        };
        if (arg0 == 3) {
            return 10
        };
        if (arg0 == 4) {
            return 20
        };
        if (arg0 == 5) {
            return 40
        };
        if (arg0 == 6) {
            return 60
        };
        if (arg0 == 7) {
            return 80
        };
        100
    }

    public fun craft_slot_capacity(arg0: u64) : u64 {
        if (arg0 < 10) {
            return 2
        };
        if (arg0 < 20) {
            return 3
        };
        if (arg0 < 40) {
            return 4
        };
        if (arg0 < 60) {
            return 5
        };
        if (arg0 < 80) {
            return 6
        };
        if (arg0 < 100) {
            return 7
        };
        8
    }

    public fun craft_success_bp(arg0: u64) : u64 {
        let v0 = 5000 + (arg0 - 1) * 50;
        if (v0 > 9900) {
            9900
        } else {
            v0
        }
    }

    public fun craft_xp(arg0: u64) : u64 {
        if (arg0 <= 2) {
            10
        } else if (arg0 == 3) {
            25
        } else if (arg0 == 4) {
            50
        } else if (arg0 == 5) {
            100
        } else if (arg0 == 6) {
            250
        } else if (arg0 == 7) {
            500
        } else {
            1000
        }
    }

    public fun craft_xp_at_level(arg0: u64, arg1: u64) : u64 {
        if (arg0 + 3 < craft_slot_capacity(arg1)) {
            0
        } else {
            craft_xp(arg0)
        }
    }

    public fun gather_quantity_bounds(arg0: u64, arg1: u64) : (u64, u64) {
        let v0 = 1 + 5 * (arg0 - 1) / 99;
        let v1 = 2 + (arg0 - arg1) / 5;
        let v2 = if (v1 < v0) {
            v0
        } else {
            v1
        };
        (v0, v2)
    }

    public fun gather_time_ms(arg0: u64) : u64 {
        let v0 = 12000 - 10000 * (arg0 - 1) / 99;
        if (v0 < 2000) {
            2000
        } else {
            v0
        }
    }

    public fun gather_xp(arg0: u64) : u64 {
        10 + arg0 / 2
    }

    public fun gathering_tool(arg0: &0x1::string::String) : 0x1::string::String {
        if (*arg0 == 0x1::string::utf8(b"FARMER")) {
            return 0x1::string::utf8(b"tool_farmer")
        };
        if (*arg0 == 0x1::string::utf8(b"HERBALIST")) {
            return 0x1::string::utf8(b"tool_herbalist")
        };
        0x1::string::utf8(b"tool_miner")
    }

    public fun level_and_next_xp(arg0: u64) : (u64, u64) {
        let v0 = vector[0, 0, 50, 140, 271, 441, 653, 905, 1199, 1534, 1911, 2330, 2792, 3297, 3846, 4439, 5078, 5762, 6493, 7271, 8097, 8973, 9898, 10875, 11903, 12985, 14122, 15315, 16564, 17873, 19242, 20672, 22166, 23726, 25353, 27048, 28815, 30656, 32572, 34566, 36641, 38800, 41044, 43378, 45804, 48325, 50946, 53669, 56498, 59437, 62491, 65664, 68960, 72385, 75943, 79640, 83482, 87475, 91624, 95937, 100421, 105082, 109930, 114971, 120215, 125671, 131348, 137256, 143407, 149811, 156481, 163429, 170669, 178214, 186080, 194283, 202839, 211765, 221082, 230808, 240964, 251574, 262660, 274248, 286364, 299037, 312297, 326175, 340705, 355924, 371870, 388582, 406106, 424486, 443772, 464016, 485274, 507604, 531071, 555541, 581687];
        let v1 = level_in_curve(&v0, arg0);
        let v2 = if (v1 == 100) {
            0
        } else {
            *0x1::vector::borrow<u64>(&v0, v1 + 1)
        };
        (v1, v2)
    }

    public fun level_from_xp(arg0: u64) : u64 {
        let v0 = vector[0, 0, 50, 140, 271, 441, 653, 905, 1199, 1534, 1911, 2330, 2792, 3297, 3846, 4439, 5078, 5762, 6493, 7271, 8097, 8973, 9898, 10875, 11903, 12985, 14122, 15315, 16564, 17873, 19242, 20672, 22166, 23726, 25353, 27048, 28815, 30656, 32572, 34566, 36641, 38800, 41044, 43378, 45804, 48325, 50946, 53669, 56498, 59437, 62491, 65664, 68960, 72385, 75943, 79640, 83482, 87475, 91624, 95937, 100421, 105082, 109930, 114971, 120215, 125671, 131348, 137256, 143407, 149811, 156481, 163429, 170669, 178214, 186080, 194283, 202839, 211765, 221082, 230808, 240964, 251574, 262660, 274248, 286364, 299037, 312297, 326175, 340705, 355924, 371870, 388582, 406106, 424486, 443772, 464016, 485274, 507604, 531071, 555541, 581687];
        level_in_curve(&v0, arg0)
    }

    fun level_in_curve(arg0: &vector<u64>, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 1
        };
        if (arg1 >= *0x1::vector::borrow<u64>(arg0, 100)) {
            return 100
        };
        let v0 = 1;
        let v1 = 100;
        while (v0 < v1) {
            let v2 = (v0 + v1 + 1) / 2;
            if (*0x1::vector::borrow<u64>(arg0, v2) <= arg1) {
                v0 = v2;
                continue
            };
            v1 = v2 - 1;
        };
        v0
    }

    public fun max_craft_ingredients() : u64 {
        8
    }

    public fun max_level() : u64 {
        100
    }

    public fun tier_to_level(arg0: u64) : u64 {
        if (arg0 <= 1) {
            return 1
        };
        let v0 = (arg0 - 1) * 10;
        if (v0 > 100) {
            100
        } else {
            v0
        }
    }

    // decompiled from Move bytecode v7
}

