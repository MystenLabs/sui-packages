module 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules {
    public fun category_fits(arg0: &0x1::string::String, arg1: &0x1::string::String) : bool {
        if (*arg0 == 0x1::string::utf8(b"weapon")) {
            return is_weapon(arg1)
        };
        if (*arg0 == 0x1::string::utf8(b"tool")) {
            return is_tool(arg1)
        };
        if (*arg0 == 0x1::string::utf8(b"left_ring") || *arg0 == 0x1::string::utf8(b"right_ring")) {
            return *arg1 == 0x1::string::utf8(b"ring")
        };
        if (is_relic_slot(arg0)) {
            return *arg1 == 0x1::string::utf8(b"relic")
        };
        *arg0 == *arg1
    }

    public fun craft_job_of(arg0: &0x1::string::String) : 0x1::option::Option<0x1::string::String> {
        let v0 = if (*arg0 == 0x1::string::utf8(b"sword")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"daggers")) {
            true
        } else {
            *arg0 == 0x1::string::utf8(b"axe")
        };
        if (v0) {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(b"FORGER"))
        } else if (*arg0 == 0x1::string::utf8(b"bow") || *arg0 == 0x1::string::utf8(b"spear")) {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(b"CARVER"))
        } else if (*arg0 == 0x1::string::utf8(b"hat") || *arg0 == 0x1::string::utf8(b"cloak")) {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(b"TAILOR"))
        } else if (*arg0 == 0x1::string::utf8(b"boots") || *arg0 == 0x1::string::utf8(b"belt")) {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(b"TANNER"))
        } else if (*arg0 == 0x1::string::utf8(b"ring") || *arg0 == 0x1::string::utf8(b"amulet")) {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(b"JEWELER"))
        } else if (*arg0 == 0x1::string::utf8(b"key")) {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(b"HANDYMAN"))
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    public fun is_category(arg0: &0x1::string::String) : bool {
        if (*arg0 == 0x1::string::utf8(b"hat")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"cloak")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"belt")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"boots")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"amulet")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"ring")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"pet")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"relic")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"title")) {
            true
        } else if (is_weapon(arg0)) {
            true
        } else if (is_tool(arg0)) {
            true
        } else if (is_stackable(arg0)) {
            true
        } else {
            is_cosmetic(arg0)
        }
    }

    public fun is_classe(arg0: &0x1::string::String) : bool {
        if (*arg0 == 0x1::string::utf8(b"shugo")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"tomoda")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"rojin")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"yajin")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"tokei")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"asobi")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"iyashi")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"senshi")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"yogan")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"mori")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"ikari")) {
            true
        } else {
            *arg0 == 0x1::string::utf8(b"shusen")
        }
    }

    public fun is_cosmetic(arg0: &0x1::string::String) : bool {
        *arg0 == 0x1::string::utf8(b"cosmetic_hat") || *arg0 == 0x1::string::utf8(b"cosmetic_cloak")
    }

    public fun is_printable_ascii(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            let v2 = *0x1::vector::borrow<u8>(v0, v1);
            if (v2 < 33 || v2 > 126) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun is_relic_slot(arg0: &0x1::string::String) : bool {
        if (*arg0 == 0x1::string::utf8(b"relic_1")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"relic_2")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"relic_3")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"relic_4")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"relic_5")) {
            true
        } else {
            *arg0 == 0x1::string::utf8(b"relic_6")
        }
    }

    public fun is_slot(arg0: &0x1::string::String) : bool {
        if (*arg0 == 0x1::string::utf8(b"weapon")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"tool")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"hat")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"cloak")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"belt")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"boots")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"amulet")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"left_ring")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"right_ring")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"pet")) {
            true
        } else if (is_relic_slot(arg0)) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"title")) {
            true
        } else {
            is_cosmetic(arg0)
        }
    }

    public fun is_stackable(arg0: &0x1::string::String) : bool {
        if (*arg0 == 0x1::string::utf8(b"consumable")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"resource")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"rune")) {
            true
        } else {
            *arg0 == 0x1::string::utf8(b"key")
        }
    }

    fun is_tool(arg0: &0x1::string::String) : bool {
        if (*arg0 == 0x1::string::utf8(b"tool_farmer")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"tool_herbalist")) {
            true
        } else {
            *arg0 == 0x1::string::utf8(b"tool_miner")
        }
    }

    fun is_weapon(arg0: &0x1::string::String) : bool {
        if (*arg0 == 0x1::string::utf8(b"daggers")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"spear")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"bow")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"axe")) {
            true
        } else {
            *arg0 == 0x1::string::utf8(b"sword")
        }
    }

    public fun pet_accepts(arg0: &vector<0x1::string::String>, arg1: &0x1::string::String) : bool {
        0x1::vector::contains<0x1::string::String>(arg0, arg1)
    }

    public fun relic_slot(arg0: u8) : 0x1::string::String {
        if (arg0 == 1) {
            return 0x1::string::utf8(b"relic_1")
        };
        if (arg0 == 2) {
            return 0x1::string::utf8(b"relic_2")
        };
        if (arg0 == 3) {
            return 0x1::string::utf8(b"relic_3")
        };
        if (arg0 == 4) {
            return 0x1::string::utf8(b"relic_4")
        };
        if (arg0 == 5) {
            return 0x1::string::utf8(b"relic_5")
        };
        0x1::string::utf8(b"relic_6")
    }

    // decompiled from Move bytecode v7
}

