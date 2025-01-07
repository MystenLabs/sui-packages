module 0x8fdf34d38b32953109918d4d4e4aba60381961cb861645a5602c6cba25f1efc1::fight {
    public fun action(arg0: u64, arg1: &mut 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role, arg2: &mut 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role, arg3: &mut vector<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>, arg4: &mut vector<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>, arg5: &mut 0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp) {
        let v0 = 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_sp(arg1);
        if (v0 >= 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_sp_cap(arg1) + get_extra_sp_cap_debuff(arg4) && 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_effect_type(arg1) == 0x1::string::utf8(b"skill")) {
            let v1 = 0x1::string::utf8(b"skill:");
            0x1::debug::print<0x1::string::String>(&v1);
            let v2 = 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_effect(arg1);
            0x1::debug::print<0x1::string::String>(&v2);
            call_skill(arg0, arg1, arg2, arg3, arg4, arg5);
            0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::set_sp(arg1, 0);
        } else {
            let v3 = 0x1::string::utf8(b"attack:");
            0x1::debug::print<0x1::string::String>(&v3);
            let v4 = 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_attack(arg1);
            0x1::debug::print<u64>(&v4);
            standard_attack(arg1, arg2);
            0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::set_sp(arg1, v0 + 1);
        };
    }

    public fun call_skill(arg0: u64, arg1: &mut 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role, arg2: &mut 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role, arg3: &mut vector<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>, arg4: &mut vector<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>, arg5: &mut 0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::LineUp) {
        let v0 = 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_effect(arg1);
        let v1 = 0x1::string::utf8(b"skill");
        0x1::debug::print<0x1::string::String>(&v1);
        0x1::debug::print<0x1::string::String>(&v0);
        let v2 = false;
        let v3 = false;
        let v4 = 0;
        let v5 = 0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg4);
        while (v4 < v5) {
            assert!(0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg4) > v4, 1);
            let v6 = 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_effect(0x1::vector::borrow<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg4, v4));
            if (v6 == 0x1::string::utf8(b"forbid_buff")) {
                v2 = true;
            };
            if (v6 == 0x1::string::utf8(b"forbid_debuff")) {
                v3 = true;
            };
            if (v2 && v3) {
                break
            };
            v4 = v4 + 1;
        };
        if (v0 == 0x1::string::utf8(b"aoe")) {
            let v7 = 0xd676f5b01f25ceace77b17fbbc91cbb2a5b43eea7695b99b32d15866f6a706d8::utils::utf8_to_u64(0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_effect_value(arg1));
            let v8 = 0;
            safe_attack(v7, arg2);
            while (v8 < v5) {
                assert!(0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg4) > v8, 1);
                let v9 = 0x1::vector::borrow_mut<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg4, v8);
                safe_attack(v7, v9);
                v8 = v8 + 1;
            };
        } else if (v0 == 0x1::string::utf8(b"add_all_tmp_hp")) {
            if (v2) {
                let v10 = 0x1::string::utf8(b"buff forbiden");
                0x1::debug::print<0x1::string::String>(&v10);
                return
            };
            let v11 = 0xd676f5b01f25ceace77b17fbbc91cbb2a5b43eea7695b99b32d15866f6a706d8::utils::utf8_to_u64(0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_effect_value(arg1));
            0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::set_hp(arg1, 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_hp(arg1) + v11);
            let v12 = 0;
            while (v12 < 0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg3)) {
                assert!(0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg3) > v12, 1);
                let v13 = 0x1::vector::borrow_mut<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg3, v12);
                heal(v11, v13);
                v12 = v12 + 1;
            };
        } else if (v0 == 0x1::string::utf8(b"add_all_tmp_attack")) {
            if (v2) {
                let v14 = 0x1::string::utf8(b"buff forbiden");
                0x1::debug::print<0x1::string::String>(&v14);
                return
            };
            let v15 = 0xd676f5b01f25ceace77b17fbbc91cbb2a5b43eea7695b99b32d15866f6a706d8::utils::utf8_to_u64(0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_effect_value(arg1));
            0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::set_attack(arg1, 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_attack(arg1) + v15);
            let v16 = 0;
            while (v16 < 0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg3)) {
                assert!(0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg3) > v16, 1);
                let v17 = 0x1::vector::borrow_mut<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg3, v16);
                increase_attack(v15, v17);
                v16 = v16 + 1;
            };
        } else if (v0 == 0x1::string::utf8(b"add_all_tmp_sp")) {
            if (v2) {
                let v18 = 0x1::string::utf8(b"buff forbiden");
                0x1::debug::print<0x1::string::String>(&v18);
                return
            };
            let v19 = 0;
            while (v19 < 0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg3)) {
                assert!(0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg3) > v19, 1);
                let v20 = 0x1::vector::borrow_mut<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg3, v19);
                0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::set_sp(v20, 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_sp(v20) + (0xd676f5b01f25ceace77b17fbbc91cbb2a5b43eea7695b99b32d15866f6a706d8::utils::utf8_to_u64(0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_effect_value(arg1)) as u8));
                v19 = v19 + 1;
            };
        } else if (v0 == 0x1::string::utf8(b"all_max_hp_to_back1")) {
            if (v2) {
                let v21 = 0x1::string::utf8(b"buff forbiden");
                0x1::debug::print<0x1::string::String>(&v21);
                return
            };
            let v22 = 0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::get_mut_roles(arg5);
            if (arg0 == 5) {
                return
            };
            assert!(0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(v22) > arg0 + 1, 1);
            let v23 = 0x1::vector::borrow_mut<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(v22, arg0 + 1);
            0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::set_hp(v23, 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_hp(v23) + 0xd676f5b01f25ceace77b17fbbc91cbb2a5b43eea7695b99b32d15866f6a706d8::utils::utf8_to_u64(0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_effect_value(arg1)));
        } else if (v0 == 0x1::string::utf8(b"reduce_tmp_attack")) {
            if (v3) {
                let v24 = 0x1::string::utf8(b"debuff forbiden");
                0x1::debug::print<0x1::string::String>(&v24);
                return
            };
            safe_reduce_attack(0xd676f5b01f25ceace77b17fbbc91cbb2a5b43eea7695b99b32d15866f6a706d8::utils::utf8_to_u64(0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_effect_value(arg1)), arg2);
        } else if (v0 == 0x1::string::utf8(b"reduce_all_tmp_attack")) {
            if (v3) {
                let v25 = 0x1::string::utf8(b"debuff forbiden");
                0x1::debug::print<0x1::string::String>(&v25);
                return
            };
            let v26 = 0xd676f5b01f25ceace77b17fbbc91cbb2a5b43eea7695b99b32d15866f6a706d8::utils::utf8_to_u64(0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_effect_value(arg1));
            safe_reduce_attack(v26, arg2);
            let v27 = 0;
            while (v27 < v5) {
                assert!(0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg4) > v27, 1);
                let v28 = 0x1::vector::borrow_mut<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg4, v27);
                safe_reduce_attack(v26, v28);
                v27 = v27 + 1;
            };
        } else if (v0 == 0x1::string::utf8(b"attack_sputter_to_second_by_percent")) {
            let v29 = 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_attack(arg1);
            safe_attack(v29, arg2);
            if (0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg4) == 0) {
                return
            };
            assert!(0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg4) > v5 - 1, 1);
            let v30 = 0x1::vector::borrow_mut<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg4, v5 - 1);
            safe_attack(v29 * 0xd676f5b01f25ceace77b17fbbc91cbb2a5b43eea7695b99b32d15866f6a706d8::utils::utf8_to_u64(0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_effect_value(arg1)) / 10, v30);
        } else if (v0 == 0x1::string::utf8(b"attack_last_char")) {
            if (0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg4) == 0) {
                safe_attack(0xd676f5b01f25ceace77b17fbbc91cbb2a5b43eea7695b99b32d15866f6a706d8::utils::utf8_to_u64(0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_effect_value(arg1)), arg2);
            } else {
                assert!(0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg4) > 0, 1);
                let v31 = 0x1::vector::borrow_mut<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg4, 0);
                safe_attack(0xd676f5b01f25ceace77b17fbbc91cbb2a5b43eea7695b99b32d15866f6a706d8::utils::utf8_to_u64(0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_effect_value(arg1)), v31);
            };
        } else if (v0 == 0x1::string::utf8(b"attack_lowest_hp")) {
            let v32 = find_lowest_hp_one(arg2, arg4);
            safe_attack(0xd676f5b01f25ceace77b17fbbc91cbb2a5b43eea7695b99b32d15866f6a706d8::utils::utf8_to_u64(0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_effect_value(arg1)), v32);
        } else if (v0 == 0x1::string::utf8(b"attack_by_hp_percent")) {
            let v33 = 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_attack(arg1) + 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_hp(arg2) * 0xd676f5b01f25ceace77b17fbbc91cbb2a5b43eea7695b99b32d15866f6a706d8::utils::utf8_to_u64(0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_effect_value(arg1)) / 10;
            safe_attack(v33, arg1);
        };
    }

    fun find_lowest_hp_one(arg0: &mut 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role, arg1: &mut vector<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>) : &mut 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role {
        let v0 = 10000;
        let v1 = 0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg1);
        if (v1 == 0) {
            return arg0
        };
        let v2 = 0;
        while (v2 < v1) {
            assert!(0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg1) > v2, 1);
            let v3 = 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_hp(0x1::vector::borrow<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg1, v2));
            if (v3 > 0) {
            };
            v2 = v2 + 1;
        };
        if (v0 != 10000) {
            assert!(0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg1) > v0, 1);
            return 0x1::vector::borrow_mut<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg1, v0)
        };
        arg0
    }

    fun get_extra_sp_cap_debuff(arg0: &vector<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>) : u8 {
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg0)) {
            let v3 = 0x1::vector::borrow<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg0, v2);
            if (0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_effect(v3) == 0x1::string::utf8(b"add_all_tmp_sp_cap")) {
                let v4 = (0xd676f5b01f25ceace77b17fbbc91cbb2a5b43eea7695b99b32d15866f6a706d8::utils::utf8_to_u64(0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_effect_value(v3)) as u8);
                if (v4 > v0) {
                    v1 = v4;
                };
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun heal(arg0: u64, arg1: &mut 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role) {
        let v0 = 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_hp(arg1);
        if (v0 == 0) {
            return
        };
        0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::set_hp(arg1, v0 + arg0);
    }

    public fun increase_attack(arg0: u64, arg1: &mut 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role) {
        if (0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_hp(arg1) == 0) {
            return
        };
        0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::set_attack(arg1, 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_attack(arg1) + arg0);
    }

    public fun safe_attack(arg0: u64, arg1: &mut 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role) {
        let v0 = 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_hp(arg1);
        if (v0 <= arg0) {
            0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::set_hp(arg1, 0);
            let v1 = 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_class(arg1);
            0x1::debug::print<0x1::string::String>(&v1);
            let v2 = 0x1::string::utf8(b"is dead");
            0x1::debug::print<0x1::string::String>(&v2);
        } else {
            0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::set_hp(arg1, v0 - arg0);
        };
        let v3 = 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_class(arg1);
        0x1::debug::print<0x1::string::String>(&v3);
        let v4 = 0x1::string::utf8(b"before after hp:");
        0x1::debug::print<0x1::string::String>(&v4);
        0x1::debug::print<u64>(&v0);
        let v5 = 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_hp(arg1);
        0x1::debug::print<u64>(&v5);
    }

    public fun safe_reduce_attack(arg0: u64, arg1: &mut 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role) {
        let v0 = 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_attack(arg1);
        if (0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_hp(arg1) == 0) {
            return
        };
        if (v0 <= arg0) {
            0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::set_attack(arg1, 1);
        } else {
            0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::set_attack(arg1, v0 - arg0);
        };
    }

    public fun some_alive(arg0: &0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role, arg1: &vector<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>) : bool {
        let v0 = 0;
        if (0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_class(arg0) != 0x1::string::utf8(b"init") && 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_hp(arg0) > 0) {
            return true
        };
        while (v0 < 0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg1)) {
            assert!(0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg1) > v0, 1);
            let v1 = 0x1::vector::borrow<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg1, v0);
            if (0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_class(v1) != 0x1::string::utf8(b"none") && 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_hp(v1) > 0) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun standard_attack(arg0: &0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role, arg1: &mut 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role) {
        safe_attack(0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_attack(arg0), arg1);
    }

    // decompiled from Move bytecode v6
}

