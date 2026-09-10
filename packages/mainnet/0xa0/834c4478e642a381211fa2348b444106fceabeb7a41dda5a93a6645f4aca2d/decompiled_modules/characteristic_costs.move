module 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::characteristic_costs {
    fun agility_cost(arg0: &0x1::string::String, arg1: u32) : u16 {
        if (*arg0 == 0x1::string::utf8(b"ikari")) {
            berserker(arg1)
        } else if (*arg0 == 0x1::string::utf8(b"shusen")) {
            three_cap(arg1)
        } else if (*arg0 == 0x1::string::utf8(b"yajin")) {
            standard(arg1)
        } else if (*arg0 == 0x1::string::utf8(b"asobi") || *arg0 == 0x1::string::utf8(b"yogan")) {
            agility_fifty(arg1)
        } else {
            short(arg1)
        }
    }

    fun agility_fifty(arg0: u32) : u16 {
        if (arg0 < 50) {
            1
        } else if (arg0 < 100) {
            2
        } else if (arg0 < 150) {
            3
        } else if (arg0 < 200) {
            4
        } else {
            5
        }
    }

    fun berserker(arg0: u32) : u16 {
        if (arg0 < 100) {
            3
        } else if (arg0 < 150) {
            4
        } else {
            5
        }
    }

    fun chance_cost(arg0: &0x1::string::String, arg1: u32) : u16 {
        if (*arg0 == 0x1::string::utf8(b"ikari")) {
            berserker(arg1)
        } else if (*arg0 == 0x1::string::utf8(b"shusen")) {
            three_cap(arg1)
        } else if (*arg0 == 0x1::string::utf8(b"tomoda") || *arg0 == 0x1::string::utf8(b"mori")) {
            standard(arg1)
        } else if (*arg0 == 0x1::string::utf8(b"rojin")) {
            if (arg1 < 100) {
                1
            } else if (arg1 < 150) {
                2
            } else if (arg1 < 230) {
                3
            } else if (arg1 < 330) {
                4
            } else {
                5
            }
        } else {
            short(arg1)
        }
    }

    public fun cost_at(arg0: &0x1::string::String, arg1: &0x1::string::String, arg2: u32) : (u16, u16) {
        assert!(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::is_classe(arg0), 1);
        if (*arg1 == 0x1::string::utf8(b"vitality")) {
            if (*arg0 == 0x1::string::utf8(b"ikari")) {
                (1, 2)
            } else {
                (1, 1)
            }
        } else if (*arg1 == 0x1::string::utf8(b"wisdom")) {
            (3, 1)
        } else {
            let (v2, v3) = if (*arg1 == 0x1::string::utf8(b"strength")) {
                (1, strength_cost(arg0, arg2))
            } else {
                let (v4, v5) = if (*arg1 == 0x1::string::utf8(b"intelligence")) {
                    (intelligence_cost(arg0, arg2), 1)
                } else if (*arg1 == 0x1::string::utf8(b"chance")) {
                    (chance_cost(arg0, arg2), 1)
                } else {
                    assert!(*arg1 == 0x1::string::utf8(b"agility"), 2);
                    (agility_cost(arg0, arg2), 1)
                };
                (v5, v4)
            };
            (v3, v2)
        }
    }

    fun expensive(arg0: u32) : u16 {
        if (arg0 < 50) {
            2
        } else if (arg0 < 150) {
            3
        } else if (arg0 < 250) {
            4
        } else {
            5
        }
    }

    fun fifty(arg0: u32) : u16 {
        if (arg0 < 50) {
            1
        } else if (arg0 < 150) {
            2
        } else if (arg0 < 250) {
            3
        } else if (arg0 < 350) {
            4
        } else {
            5
        }
    }

    public fun gain_for_points(arg0: &0x1::string::String, arg1: &0x1::string::String, arg2: u16, arg3: u16) : (u32, u32) {
        let v0 = 0;
        let v1 = 0;
        let v2 = (arg3 as u32);
        while (v2 > 0) {
            let (v3, v4) = cost_at(arg0, arg1, (arg2 as u32) + v1);
            let v5 = (v3 as u32);
            if (v2 < v5) {
                return (v0, v1)
            };
            v0 = v0 + v5;
            v2 = v2 - v5;
            v1 = v1 + (v4 as u32);
        };
        (v0, v1)
    }

    fun intelligence_cost(arg0: &0x1::string::String, arg1: u32) : u16 {
        if (*arg0 == 0x1::string::utf8(b"ikari")) {
            berserker(arg1)
        } else if (*arg0 == 0x1::string::utf8(b"shusen")) {
            three_cap(arg1)
        } else {
            let v1 = if (*arg0 == 0x1::string::utf8(b"shugo")) {
                true
            } else if (*arg0 == 0x1::string::utf8(b"tomoda")) {
                true
            } else if (*arg0 == 0x1::string::utf8(b"tokei")) {
                true
            } else if (*arg0 == 0x1::string::utf8(b"iyashi")) {
                true
            } else {
                *arg0 == 0x1::string::utf8(b"mori")
            };
            if (v1) {
                standard(arg1)
            } else if (*arg0 == 0x1::string::utf8(b"yajin")) {
                expensive(arg1)
            } else if (*arg0 == 0x1::string::utf8(b"asobi") || *arg0 == 0x1::string::utf8(b"senshi")) {
                short(arg1)
            } else if (*arg0 == 0x1::string::utf8(b"yogan")) {
                fifty(arg1)
            } else if (arg1 < 20) {
                1
            } else if (arg1 < 60) {
                2
            } else if (arg1 < 100) {
                3
            } else if (arg1 < 150) {
                4
            } else {
                5
            }
        }
    }

    fun short(arg0: u32) : u16 {
        if (arg0 < 20) {
            1
        } else if (arg0 < 40) {
            2
        } else if (arg0 < 60) {
            3
        } else if (arg0 < 80) {
            4
        } else {
            5
        }
    }

    fun standard(arg0: u32) : u16 {
        if (arg0 < 100) {
            1
        } else if (arg0 < 200) {
            2
        } else if (arg0 < 300) {
            3
        } else if (arg0 < 400) {
            4
        } else {
            5
        }
    }

    fun strength_cost(arg0: &0x1::string::String, arg1: u32) : u16 {
        if (*arg0 == 0x1::string::utf8(b"ikari")) {
            berserker(arg1)
        } else if (*arg0 == 0x1::string::utf8(b"shusen")) {
            three_cap(arg1)
        } else {
            let v1 = if (*arg0 == 0x1::string::utf8(b"shugo")) {
                true
            } else if (*arg0 == 0x1::string::utf8(b"tomoda")) {
                true
            } else if (*arg0 == 0x1::string::utf8(b"tokei")) {
                true
            } else {
                *arg0 == 0x1::string::utf8(b"iyashi")
            };
            if (v1) {
                expensive(arg1)
            } else {
                let v2 = if (*arg0 == 0x1::string::utf8(b"yajin")) {
                    true
                } else if (*arg0 == 0x1::string::utf8(b"asobi")) {
                    true
                } else {
                    *arg0 == 0x1::string::utf8(b"senshi")
                };
                if (v2) {
                    standard(arg1)
                } else if (*arg0 == 0x1::string::utf8(b"yogan") || *arg0 == 0x1::string::utf8(b"rojin")) {
                    fifty(arg1)
                } else if (arg1 < 50) {
                    1
                } else if (arg1 < 250) {
                    2
                } else if (arg1 < 300) {
                    3
                } else if (arg1 < 400) {
                    4
                } else {
                    5
                }
            }
        }
    }

    fun three_cap(arg0: u32) : u16 {
        if (arg0 < 50) {
            1
        } else if (arg0 < 200) {
            2
        } else {
            3
        }
    }

    // decompiled from Move bytecode v7
}

