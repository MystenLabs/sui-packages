module 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::fight {
    public(friend) fun action(arg0: u64, arg1: &mut 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role, arg2: &mut 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role, arg3: &mut vector<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>, arg4: &mut vector<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>, arg5: &mut 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::LineUp) {
        let v0 = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_magic(arg1);
        if (v0 >= 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_max_magic(arg1) + get_extra_max_magic_debuff(arg4) && 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_effect_type(arg1) == 0x1::string::utf8(b"skill")) {
            let v1 = 0x1::string::utf8(b"skill:");
            0x1::debug::print<0x1::string::String>(&v1);
            let v2 = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_effect(arg1);
            0x1::debug::print<0x1::string::String>(&v2);
            call_skill(arg0, arg1, arg2, arg3, arg4, arg5);
            0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::set_magic(arg1, 0);
        } else {
            let v3 = 0x1::string::utf8(b"attack:");
            0x1::debug::print<0x1::string::String>(&v3);
            let v4 = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_attack(arg1);
            0x1::debug::print<u64>(&v4);
            call_attack(arg1, arg2);
            0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::set_magic(arg1, v0 + 1);
        };
    }

    public(friend) fun call_attack(arg0: &0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role, arg1: &mut 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role) {
        safe_attack(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_attack(arg0), arg1);
    }

    public(friend) fun call_skill(arg0: u64, arg1: &mut 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role, arg2: &mut 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role, arg3: &mut vector<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>, arg4: &mut vector<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>, arg5: &mut 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::LineUp) {
        let v0 = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_effect(arg1);
        let v1 = 0x1::string::utf8(b"skill");
        0x1::debug::print<0x1::string::String>(&v1);
        0x1::debug::print<0x1::string::String>(&v0);
        let v2 = false;
        let v3 = false;
        let v4 = 0;
        let v5 = 0x1::vector::length<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg4);
        while (v4 < v5) {
            let v6 = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_effect(0x1::vector::borrow<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg4, v4));
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
            let v7 = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::utils::utf8_to_u64(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_effect_value(arg1));
            let v8 = 0;
            safe_attack(v7, arg2);
            while (v8 < v5) {
                let v9 = 0x1::vector::borrow_mut<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg4, v8);
                safe_attack(v7, v9);
                v8 = v8 + 1;
            };
        } else if (v0 == 0x1::string::utf8(b"add_all_tmp_hp")) {
            if (v2) {
                let v10 = 0x1::string::utf8(b"buff forbiden");
                0x1::debug::print<0x1::string::String>(&v10);
                return
            };
            let v11 = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::utils::utf8_to_u64(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_effect_value(arg1));
            0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::set_life(arg1, 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_life(arg1) + v11);
            let v12 = 0;
            while (v12 < 0x1::vector::length<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg3)) {
                let v13 = 0x1::vector::borrow_mut<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg3, v12);
                safe_add_hp(v11, v13);
                v12 = v12 + 1;
            };
        } else if (v0 == 0x1::string::utf8(b"add_all_tmp_attack")) {
            if (v2) {
                let v14 = 0x1::string::utf8(b"buff forbiden");
                0x1::debug::print<0x1::string::String>(&v14);
                return
            };
            let v15 = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::utils::utf8_to_u64(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_effect_value(arg1));
            0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::set_attack(arg1, 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_life(arg1) + v15);
            let v16 = 0;
            while (v16 < 0x1::vector::length<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg3)) {
                let v17 = 0x1::vector::borrow_mut<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg3, v16);
                safe_add_attack(v15, v17);
                v16 = v16 + 1;
            };
        } else if (v0 == 0x1::string::utf8(b"add_all_tmp_magic")) {
            if (v2) {
                let v18 = 0x1::string::utf8(b"buff forbiden");
                0x1::debug::print<0x1::string::String>(&v18);
                return
            };
            let v19 = 0;
            while (v19 < 0x1::vector::length<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg3)) {
                let v20 = 0x1::vector::borrow_mut<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg3, v19);
                0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::set_magic(v20, 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_magic(v20) + (0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::utils::utf8_to_u64(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_effect_value(arg1)) as u8));
                v19 = v19 + 1;
            };
        } else if (v0 == 0x1::string::utf8(b"all_max_hp_to_back1")) {
            if (v2) {
                let v21 = 0x1::string::utf8(b"buff forbiden");
                0x1::debug::print<0x1::string::String>(&v21);
                return
            };
            let v22 = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::get_mut_roles(arg5);
            if (arg0 == 5) {
                return
            };
            let v23 = 0x1::vector::borrow_mut<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(v22, arg0 + 1);
            0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::set_life(v23, 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_life(v23) + 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::utils::utf8_to_u64(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_effect_value(arg1)));
        } else if (v0 == 0x1::string::utf8(b"reduce_tmp_attack")) {
            if (v3) {
                let v24 = 0x1::string::utf8(b"debuff forbiden");
                0x1::debug::print<0x1::string::String>(&v24);
                return
            };
            safe_reduce_attack(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::utils::utf8_to_u64(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_effect_value(arg1)), arg2);
        } else if (v0 == 0x1::string::utf8(b"reduce_all_tmp_attack")) {
            if (v3) {
                let v25 = 0x1::string::utf8(b"debuff forbiden");
                0x1::debug::print<0x1::string::String>(&v25);
                return
            };
            let v26 = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::utils::utf8_to_u64(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_effect_value(arg1));
            safe_reduce_attack(v26, arg2);
            let v27 = 0;
            while (v27 < v5) {
                let v28 = 0x1::vector::borrow_mut<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg4, v27);
                safe_reduce_attack(v26, v28);
                v27 = v27 + 1;
            };
        } else if (v0 == 0x1::string::utf8(b"attack_sputter_to_second_by_percent")) {
            let v29 = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_attack(arg1);
            safe_attack(v29, arg2);
            if (0x1::vector::length<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg4) == 0) {
                return
            };
            let v30 = 0x1::vector::borrow_mut<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg4, 0);
            safe_attack(v29 * 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::utils::utf8_to_u64(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_effect_value(arg1)) / 10, v30);
        } else if (v0 == 0x1::string::utf8(b"attack_last_char")) {
            if (0x1::vector::length<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg4) == 0) {
                safe_attack(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::utils::utf8_to_u64(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_effect_value(arg1)), arg2);
            } else {
                let v31 = 0x1::vector::borrow_mut<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg4, v5 - 1);
                safe_attack(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::utils::utf8_to_u64(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_effect_value(arg1)), v31);
            };
        } else if (v0 == 0x1::string::utf8(b"attack_lowest_hp")) {
            let v32 = find_lowest_life_one(arg2, arg4);
            safe_attack(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::utils::utf8_to_u64(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_effect_value(arg1)), v32);
        } else if (v0 == 0x1::string::utf8(b"attack_by_life_percent")) {
            let v33 = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_attack(arg1) + 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_life(arg2) * 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::utils::utf8_to_u64(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_effect_value(arg1)) / 10;
            safe_attack(v33, arg1);
        };
    }

    fun find_lowest_life_one(arg0: &mut 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role, arg1: &mut vector<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>) : &mut 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role {
        let v0 = 10000;
        let v1 = 0x1::vector::length<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg1);
        if (v1 == 0) {
            return arg0
        };
        let v2 = 0;
        while (v2 < v1) {
            let v3 = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_life(0x1::vector::borrow<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg1, v2));
            if (v3 > 0) {
            };
            v2 = v2 + 1;
        };
        if (v0 != 10000) {
            return 0x1::vector::borrow_mut<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg1, v0)
        };
        arg0
    }

    fun get_extra_max_magic_debuff(arg0: &vector<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>) : u8 {
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg0)) {
            let v3 = 0x1::vector::borrow<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg0, v2);
            if (0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_effect(v3) == 0x1::string::utf8(b"add_all_tmp_max_magic")) {
                let v4 = (0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::utils::utf8_to_u64(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_effect_value(v3)) as u8);
                if (v4 > v0) {
                    v1 = v4;
                };
            };
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun safe_add_attack(arg0: u64, arg1: &mut 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role) {
        if (0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_life(arg1) == 0) {
            return
        };
        0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::set_attack(arg1, 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_attack(arg1) + arg0);
    }

    public(friend) fun safe_add_hp(arg0: u64, arg1: &mut 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role) {
        let v0 = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_life(arg1);
        if (v0 == 0) {
            return
        };
        0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::set_life(arg1, v0 + arg0);
    }

    public(friend) fun safe_attack(arg0: u64, arg1: &mut 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role) {
        let v0 = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_life(arg1);
        if (v0 <= arg0) {
            0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::set_life(arg1, 0);
            let v1 = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_name(arg1);
            0x1::debug::print<0x1::string::String>(&v1);
            let v2 = 0x1::string::utf8(b"is dead");
            0x1::debug::print<0x1::string::String>(&v2);
        } else {
            0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::set_life(arg1, v0 - arg0);
        };
        let v3 = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_name(arg1);
        0x1::debug::print<0x1::string::String>(&v3);
        let v4 = 0x1::string::utf8(b"before after life:");
        0x1::debug::print<0x1::string::String>(&v4);
        0x1::debug::print<u64>(&v0);
        let v5 = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_life(arg1);
        0x1::debug::print<u64>(&v5);
    }

    public(friend) fun safe_reduce_attack(arg0: u64, arg1: &mut 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role) {
        let v0 = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_attack(arg1);
        if (0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_life(arg1) == 0) {
            return
        };
        if (v0 <= arg0) {
            0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::set_attack(arg1, 1);
        } else {
            0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::set_attack(arg1, v0 - arg0);
        };
    }

    public(friend) fun some_alive(arg0: &0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role, arg1: &vector<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>) : bool {
        let v0 = 0;
        if (0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_name(arg0) != 0x1::string::utf8(b"init") && 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_life(arg0) > 0) {
            return true
        };
        while (v0 < 0x1::vector::length<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg1)) {
            let v1 = 0x1::vector::borrow<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg1, v0);
            if (0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_name(v1) != 0x1::string::utf8(b"none") && 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_life(v1) > 0) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    // decompiled from Move bytecode v6
}

