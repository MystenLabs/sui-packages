module 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::weapon {
    public fun affinity_of(arg0: &0x1::string::String, arg1: &0x1::string::String) : bool {
        let v0 = *arg0;
        let v1 = *arg1;
        if (v0 == 0x1::string::utf8(b"senshi") && v1 == 0x1::string::utf8(b"sword")) {
            true
        } else if (v0 == 0x1::string::utf8(b"yajin") && v1 == 0x1::string::utf8(b"daggers")) {
            true
        } else if (v0 == 0x1::string::utf8(b"ikari") && v1 == 0x1::string::utf8(b"axe")) {
            true
        } else if (v0 == 0x1::string::utf8(b"mori") && v1 == 0x1::string::utf8(b"spear")) {
            true
        } else if (v0 == 0x1::string::utf8(b"tokei") && v1 == 0x1::string::utf8(b"axe")) {
            true
        } else if (v0 == 0x1::string::utf8(b"shugo") && v1 == 0x1::string::utf8(b"spear")) {
            true
        } else if (v0 == 0x1::string::utf8(b"yogan") && v1 == 0x1::string::utf8(b"bow")) {
            true
        } else if (v0 == 0x1::string::utf8(b"rojin") && v1 == 0x1::string::utf8(b"daggers")) {
            true
        } else if (v0 == 0x1::string::utf8(b"shusen") && v1 == 0x1::string::utf8(b"axe")) {
            true
        } else if (v0 == 0x1::string::utf8(b"tomoda") && v1 == 0x1::string::utf8(b"spear")) {
            true
        } else if (v0 == 0x1::string::utf8(b"asobi") && v1 == 0x1::string::utf8(b"sword")) {
            true
        } else {
            v0 == 0x1::string::utf8(b"iyashi") && v1 == 0x1::string::utf8(b"bow")
        }
    }

    fun hit(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u8, arg4: u8) : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::Effect {
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::new_effect(0, arg0, (arg1 as u32), (arg2 as u32), arg3, arg4, 0, 10000, 0, 0)
    }

    fun physics_of(arg0: &0x1::string::String) : (u16, u8, u8, u8, bool, bool, u8, u8) {
        if (*arg0 == 0x1::string::utf8(b"daggers")) {
            (30, 3, 1, 1, false, false, 0, 0)
        } else if (*arg0 == 0x1::string::utf8(b"spear")) {
            (70, 4, 1, 1, false, false, 4, 1)
        } else if (*arg0 == 0x1::string::utf8(b"bow")) {
            (60, 4, 6, 2, true, false, 0, 0)
        } else {
            let (v8, v9, v10, v11, v12, v13, v14, v15) = if (*arg0 == 0x1::string::utf8(b"axe")) {
                (5, 1, 1, false, false, 8, 1, 55)
            } else {
                let (v16, v17, v18, v19, v20, v21, v22, v23) = if (*arg0 == 0x1::string::utf8(b"sword")) {
                    (50, 5, 1, 1, false, false, 0, 0)
                } else {
                    (100, 4, 1, 1, false, false, 0, 0)
                };
                (v17, v18, v19, v20, v21, v22, v23, v16)
            };
            (v15, v8, v9, v10, v11, v12, v13, v14)
        }
    }

    fun scale(arg0: u64, arg1: bool) : u64 {
        if (arg1) {
            arg0 * 110 / 100
        } else {
            arg0
        }
    }

    public fun strike_of(arg0: &0x1::string::String, arg1: &vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_damages::ItemDamages>, arg2: bool) : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::SpellLevel {
        let (v0, v1, v2, v3, v4, v5, v6, v7) = physics_of(arg0);
        if (0x1::vector::is_empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_damages::ItemDamages>(arg1)) {
            return unarmed()
        };
        let v8 = 0x1::vector::empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::Effect>();
        let v9 = 0x1::vector::empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::Effect>();
        let v10 = 0;
        while (v10 < 0x1::vector::length<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_damages::ItemDamages>(arg1)) {
            let v11 = 0x1::vector::borrow<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_damages::ItemDamages>(arg1, v10);
            let v12 = scale((0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_damages::from(v11) as u64), arg2);
            let v13 = scale((0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_damages::to(v11) as u64), arg2);
            0x1::vector::push_back<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::Effect>(&mut v8, hit(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_damages::element(v11), v12, v13, v6, v7));
            0x1::vector::push_back<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::Effect>(&mut v9, hit(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_damages::element(v11), v12 * 150 / 100, v13 * 150 / 100, v6, v7));
            v10 = v10 + 1;
        };
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::new_spell_level(v1, v3, v2, v4, true, v5, false, 0, 0, 0, v0, v8, v9)
    }

    public fun unarmed() : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::SpellLevel {
        let v0 = 0x1::string::utf8(b"");
        let (v1, v2, v3, v4, v5, v6, v7, v8) = physics_of(&v0);
        let v9 = 0x1::vector::empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::Effect>();
        0x1::vector::push_back<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::Effect>(&mut v9, hit(0x1::string::utf8(b"earth"), 4, 4, v7, v8));
        let v10 = 0x1::vector::empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::Effect>();
        0x1::vector::push_back<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::Effect>(&mut v10, hit(0x1::string::utf8(b"earth"), 6, 6, v7, v8));
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::new_spell_level(v2, v4, v3, v5, true, v6, false, 0, 0, 0, v1, v9, v10)
    }

    // decompiled from Move bytecode v7
}

