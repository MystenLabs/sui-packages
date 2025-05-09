module 0x64b41e4a1bb35847ad66fec3519bc579f5dc26cbef0184669eae1fd9aaa8f2ef::fight {
    public fun action(arg0: &mut 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role, arg1: &mut 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role, arg2: &mut vector<0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role>, arg3: &mut vector<0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role>, arg4: &mut 0x2::vec_map::VecMap<0x1::string::String, 0xb997f87e60159a25103a3f8dc79eaefd9c5d4a48b8c056c40e124923745991b8::utils::Int_wrapper>) {
        let v0 = get_extra_sp_cap_debuff(arg1, arg3);
        let v1 = 0x1::string::utf8(b"The extra sp cap debuff is:");
        0x1::debug::print<0x1::string::String>(&v1);
        0x1::debug::print<u8>(&v0);
        let v2 = 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::get_sp(arg0);
        let v3 = if (v2 >= 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::get_sp_cap(arg0) + v0 && 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::get_effect_type(arg0) == 0x1::string::utf8(b"skill")) {
            call_skill(arg0, arg1, arg2, arg3, arg4)
        } else {
            false
        };
        if (v3) {
            let v4 = 0x1::string::utf8(b"Skill:");
            0x1::debug::print<0x1::string::String>(&v4);
            let v5 = 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::get_effect(arg0);
            0x1::debug::print<0x1::string::String>(&v5);
            let v6 = 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::get_effect_value(arg0);
            0x1::debug::print<0x1::string::String>(&v6);
            0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::set_sp(arg0, 0);
        } else {
            let v7 = 0x1::string::utf8(b"Standard attack:");
            0x1::debug::print<0x1::string::String>(&v7);
            let v8 = 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::get_attack(arg0);
            0x1::debug::print<u64>(&v8);
            standard_attack(arg0, arg1);
            0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::set_sp(arg0, v2 + 1);
        };
    }

    fun call_skill(arg0: &mut 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role, arg1: &mut 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role, arg2: &mut vector<0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role>, arg3: &mut vector<0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role>, arg4: &mut 0x2::vec_map::VecMap<0x1::string::String, 0xb997f87e60159a25103a3f8dc79eaefd9c5d4a48b8c056c40e124923745991b8::utils::Int_wrapper>) : bool {
        let v0 = 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::get_effect(arg0);
        let v1 = 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::get_effect_value(arg0);
        let v2 = 0x1::vector::length<0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role>(arg3);
        let v3 = 0x1::vector::length<0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role>(arg2);
        let (v4, v5) = set_forbidden_flag(arg1, arg3);
        if (v4) {
            let v6 = 0x1::string::utf8(b"Buff forbidden");
            0x1::debug::print<0x1::string::String>(&v6);
        };
        if (v5) {
            let v7 = 0x1::string::utf8(b"Debuff forbidden");
            0x1::debug::print<0x1::string::String>(&v7);
        };
        if (v0 == 0x1::string::utf8(b"aoe")) {
            let v8 = 0xb997f87e60159a25103a3f8dc79eaefd9c5d4a48b8c056c40e124923745991b8::utils::utf8_to_u64(v1);
            safe_attack(v8, arg1);
            let v9 = v2;
            while (v9 > 0) {
                let v10 = 0x1::vector::borrow_mut<0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role>(arg3, v9 - 1);
                if (safe_attack(v8, v10)) {
                    0x1::vector::remove<0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role>(arg3, v9 - 1);
                };
                v9 = v9 - 1;
            };
            return true
        };
        if (v0 == 0x1::string::utf8(b"attack_sputter_to_second_by_percent")) {
            let v11 = 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::get_attack(arg0);
            safe_attack(v11, arg1);
            if (v2 > 0) {
                let v12 = 0x1::vector::borrow_mut<0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role>(arg3, v2 - 1);
                if (safe_attack(v11 * 0xb997f87e60159a25103a3f8dc79eaefd9c5d4a48b8c056c40e124923745991b8::utils::utf8_to_u64(v1) / 10, v12)) {
                    0x1::vector::remove<0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role>(arg3, v2 - 1);
                };
            };
            return true
        };
        if (v0 == 0x1::string::utf8(b"attack_last_char")) {
            if (v2 == 0) {
                safe_attack(0xb997f87e60159a25103a3f8dc79eaefd9c5d4a48b8c056c40e124923745991b8::utils::utf8_to_u64(v1), arg1);
            } else {
                let v13 = 0x1::vector::borrow_mut<0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role>(arg3, 0);
                if (safe_attack(0xb997f87e60159a25103a3f8dc79eaefd9c5d4a48b8c056c40e124923745991b8::utils::utf8_to_u64(v1), v13)) {
                    0x1::vector::remove<0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role>(arg3, 0);
                };
            };
            return true
        };
        if (v0 == 0x1::string::utf8(b"attack_lowest_hp")) {
            let v14 = lowest_hp_index(arg1, arg3);
            if (v14 == 6) {
                safe_attack(0xb997f87e60159a25103a3f8dc79eaefd9c5d4a48b8c056c40e124923745991b8::utils::utf8_to_u64(v1), arg1);
            } else {
                let v15 = 0x1::vector::borrow_mut<0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role>(arg3, v14);
                if (safe_attack(0xb997f87e60159a25103a3f8dc79eaefd9c5d4a48b8c056c40e124923745991b8::utils::utf8_to_u64(v1), v15)) {
                    0x1::vector::remove<0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role>(arg3, v14);
                };
            };
            return true
        };
        if (v0 == 0x1::string::utf8(b"attack_by_hp_percent")) {
            let v16 = 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::get_attack(arg0) + 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::get_hp(arg1) * 0xb997f87e60159a25103a3f8dc79eaefd9c5d4a48b8c056c40e124923745991b8::utils::utf8_to_u64(v1) / 10;
            safe_attack(v16, arg1);
            return true
        };
        if (v0 == 0x1::string::utf8(b"add_all_tmp_hp")) {
            if (!v4) {
                let v17 = 0xb997f87e60159a25103a3f8dc79eaefd9c5d4a48b8c056c40e124923745991b8::utils::utf8_to_u64(v1);
                heal(v17, arg0);
                let v9 = 0;
                while (v9 < v3) {
                    let v18 = 0x1::vector::borrow_mut<0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role>(arg2, v9);
                    heal(v17, v18);
                    v9 = v9 + 1;
                };
                return true
            };
            return false
        };
        if (v0 == 0x1::string::utf8(b"add_all_tmp_attack")) {
            if (!v4) {
                let v19 = 0xb997f87e60159a25103a3f8dc79eaefd9c5d4a48b8c056c40e124923745991b8::utils::utf8_to_u64(v1);
                increase_attack(v19, arg0);
                let v9 = 0;
                while (v9 < v3) {
                    let v20 = 0x1::vector::borrow_mut<0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role>(arg2, v9);
                    increase_attack(v19, v20);
                    v9 = v9 + 1;
                };
                return true
            };
            return false
        };
        if (v0 == 0x1::string::utf8(b"add_all_tmp_sp")) {
            if (!v4) {
                let v9 = 0;
                while (v9 < v3) {
                    let v21 = 0x1::vector::borrow_mut<0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role>(arg2, v9);
                    0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::set_sp(v21, 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::get_sp(v21) + (0xb997f87e60159a25103a3f8dc79eaefd9c5d4a48b8c056c40e124923745991b8::utils::utf8_to_u64(v1) as u8));
                    v9 = v9 + 1;
                };
                return true
            };
            return false
        };
        if (v0 == 0x1::string::utf8(b"all_max_hp_to_back1")) {
            if (!v4) {
                if (v3 > 0) {
                    let v22 = 0x1::vector::borrow_mut<0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role>(arg2, v3 - 1);
                    let v23 = 0xb997f87e60159a25103a3f8dc79eaefd9c5d4a48b8c056c40e124923745991b8::utils::utf8_to_u64(v1);
                    heal(v23, v22);
                    let v24 = 0x1::string::utf8(b"invalid");
                    if (!0x2::vec_map::contains<0x1::string::String, 0xb997f87e60159a25103a3f8dc79eaefd9c5d4a48b8c056c40e124923745991b8::utils::Int_wrapper>(arg4, &v24)) {
                        let v25 = 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::get_class(v22);
                        if (0x2::vec_map::contains<0x1::string::String, 0xb997f87e60159a25103a3f8dc79eaefd9c5d4a48b8c056c40e124923745991b8::utils::Int_wrapper>(arg4, &v25)) {
                            let v26 = 0x2::vec_map::get_mut<0x1::string::String, 0xb997f87e60159a25103a3f8dc79eaefd9c5d4a48b8c056c40e124923745991b8::utils::Int_wrapper>(arg4, &v25);
                            0xb997f87e60159a25103a3f8dc79eaefd9c5d4a48b8c056c40e124923745991b8::utils::set_int(v26, 0xb997f87e60159a25103a3f8dc79eaefd9c5d4a48b8c056c40e124923745991b8::utils::get_int(v26) + v23);
                        } else {
                            0x2::vec_map::insert<0x1::string::String, 0xb997f87e60159a25103a3f8dc79eaefd9c5d4a48b8c056c40e124923745991b8::utils::Int_wrapper>(arg4, v25, 0xb997f87e60159a25103a3f8dc79eaefd9c5d4a48b8c056c40e124923745991b8::utils::generate_wrapper_with_value(v23));
                        };
                    };
                };
                return true
            };
            return false
        };
        if (v0 == 0x1::string::utf8(b"reduce_tmp_attack")) {
            if (!v5) {
                safe_reduce_attack(0xb997f87e60159a25103a3f8dc79eaefd9c5d4a48b8c056c40e124923745991b8::utils::utf8_to_u64(v1), arg1);
                return true
            };
            return false
        };
        if (v0 == 0x1::string::utf8(b"reduce_all_tmp_attack")) {
            if (!v5) {
                let v27 = 0xb997f87e60159a25103a3f8dc79eaefd9c5d4a48b8c056c40e124923745991b8::utils::utf8_to_u64(v1);
                safe_reduce_attack(v27, arg1);
                let v9 = 0;
                while (v9 < v2) {
                    let v28 = 0x1::vector::borrow_mut<0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role>(arg3, v9);
                    safe_reduce_attack(v27, v28);
                    v9 = v9 + 1;
                };
                return true
            };
            return false
        };
        false
    }

    fun get_extra_sp_cap_debuff(arg0: &0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role, arg1: &vector<0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role>) : u8 {
        let v0 = 0;
        let v1 = 0;
        if (0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::get_effect(arg0) == 0x1::string::utf8(b"add_all_tmp_sp_cap")) {
            v1 = 1;
            if ((0xb997f87e60159a25103a3f8dc79eaefd9c5d4a48b8c056c40e124923745991b8::utils::utf8_to_u64(0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::get_effect_value(arg0)) as u8) == 2) {
                return 2
            };
        };
        while (v0 < 0x1::vector::length<0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role>(arg1)) {
            let v2 = 0x1::vector::borrow<0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role>(arg1, v0);
            if (0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::get_effect(v2) == 0x1::string::utf8(b"add_all_tmp_sp_cap")) {
                v1 = 1;
                if (0xb997f87e60159a25103a3f8dc79eaefd9c5d4a48b8c056c40e124923745991b8::utils::utf8_to_u64(0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::get_effect_value(v2)) == 2) {
                    return 2
                };
            };
            v0 = v0 + 1;
        };
        v1
    }

    fun heal(arg0: u64, arg1: &mut 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role) {
        0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::set_hp(arg1, 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::get_hp(arg1) + arg0);
    }

    fun increase_attack(arg0: u64, arg1: &mut 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role) {
        0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::set_attack(arg1, 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::get_attack(arg1) + arg0);
    }

    fun lowest_hp_index(arg0: &0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role, arg1: &vector<0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role>) : u64 {
        let v0 = 0x1::vector::length<0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role>(arg1);
        if (v0 == 0) {
            return 6
        };
        let v1 = 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::get_hp(arg0);
        let v2 = 6;
        while (v0 > 0) {
            let v3 = v0 - 1;
            v0 = v3;
            v1 = 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::get_hp(0x1::vector::borrow<0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role>(arg1, v3));
            if (v1 < v1) {
                v2 = v3;
            };
        };
        v2
    }

    fun safe_attack(arg0: u64, arg1: &mut 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role) : bool {
        let v0 = 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::get_hp(arg1);
        let v1 = if (v0 > arg0) {
            v0 - arg0
        } else {
            0
        };
        0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::set_hp(arg1, v1);
        v1 == 0
    }

    fun safe_reduce_attack(arg0: u64, arg1: &mut 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role) {
        let v0 = 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::get_attack(arg1);
        if (v0 <= arg0) {
            0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::set_attack(arg1, 1);
        } else {
            0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::set_attack(arg1, v0 - arg0);
        };
    }

    fun set_forbidden_flag(arg0: &0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role, arg1: &vector<0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role>) : (bool, bool) {
        let v0 = false;
        let v1 = false;
        let v2 = 0;
        let v3 = 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::get_effect(arg0);
        if (v3 == 0x1::string::utf8(b"forbid_buff")) {
            v1 = true;
        };
        if (v3 == 0x1::string::utf8(b"forbid_debuff")) {
            v0 = true;
        };
        while (v2 < 0x1::vector::length<0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role>(arg1)) {
            let v4 = 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::get_effect(0x1::vector::borrow<0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role>(arg1, v2));
            if (v4 == 0x1::string::utf8(b"forbid_buff")) {
                v1 = true;
            };
            if (v4 == 0x1::string::utf8(b"forbid_debuff")) {
                v0 = true;
            };
            if (v1 && v0) {
                break
            };
            v2 = v2 + 1;
        };
        (v1, v0)
    }

    fun standard_attack(arg0: &0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role, arg1: &mut 0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::Role) : bool {
        safe_attack(0xf414aef464471ff6b58c2297351455bb6c16986a8fb277f6ebe5dfb44daeacc2::role::get_attack(arg0), arg1)
    }

    // decompiled from Move bytecode v6
}

