module 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::verify {
    public fun verify_operation(arg0: &0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Global, arg1: &mut vector<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>, arg2: &mut vector<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>, arg3: vector<0x1::string::String>, arg4: u8, arg5: vector<0x1::string::String>, arg6: 0x1::string::String, arg7: u8, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        0x1::vector::reverse<0x1::string::String>(&mut arg3);
        while (0x1::vector::length<0x1::string::String>(&arg3) > 0) {
            let v1 = 0x1::vector::pop_back<0x1::string::String>(&mut arg3);
            if (v1 == 0x1::string::utf8(b"buy_upgrade")) {
                let (v2, v3) = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::utils::get_left_right_number(0x1::vector::pop_back<0x1::string::String>(&mut arg3));
                let v4 = *0x1::vector::borrow<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg2, v2 + 5 * v0);
                assert!(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_name(&v4) != 0x1::string::utf8(b"none"), 9);
                let v5 = 0x1::vector::borrow_mut<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg1, v3);
                assert!(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_name(v5) != 0x1::string::utf8(b"none"), 9);
                assert!(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::upgrade(arg0, &v4, v5), 16);
                0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::set_name(0x1::vector::borrow_mut<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg2, v2), 0x1::string::utf8(b"none"));
                arg7 = arg7 - 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_price(&v4);
                continue
            };
            if (v1 == 0x1::string::utf8(b"buy")) {
                let (v6, v7) = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::utils::get_left_right_number(0x1::vector::pop_back<0x1::string::String>(&mut arg3));
                let v8 = 0x1::vector::borrow_mut<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg2, v6 + 5 * v0);
                assert!(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_name(v8) != 0x1::string::utf8(b"none"), 9);
                let v9 = *v8;
                0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::set_name(v8, 0x1::string::utf8(b"none"));
                assert!(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_name(0x1::vector::borrow<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg1, v7)) == 0x1::string::utf8(b"none"), 8);
                0x1::vector::remove<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg1, v7);
                0x1::vector::insert<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg1, v9, v7);
                arg7 = arg7 - 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_price(&v9);
                continue
            };
            if (v1 == 0x1::string::utf8(b"swap")) {
                let (v10, v11) = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::utils::get_left_right_number(0x1::vector::pop_back<0x1::string::String>(&mut arg3));
                0x1::vector::swap<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg1, v10, v11);
                continue
            };
            if (v1 == 0x1::string::utf8(b"sell")) {
                let v12 = 0x1::vector::borrow_mut<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg1, 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::utils::utf8_to_u64(0x1::vector::pop_back<0x1::string::String>(&mut arg3)));
                assert!(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_name(v12) != 0x1::string::utf8(b"none"), 8);
                0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::set_name(v12, 0x1::string::utf8(b"none"));
                arg7 = arg7 + 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_sell_price(v12);
                continue
            };
            if (v1 == 0x1::string::utf8(b"upgrade")) {
                let (v13, v14) = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::utils::get_left_right_number(0x1::vector::pop_back<0x1::string::String>(&mut arg3));
                assert!(v13 != v14, 17);
                let v15 = *0x1::vector::borrow<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg1, v13);
                assert!(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_name(&v15) != 0x1::string::utf8(b"none"), 9);
                let v16 = 0x1::vector::borrow_mut<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg1, v14);
                assert!(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::get_name(v16) != 0x1::string::utf8(b"none"), 9);
                assert!(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::upgrade(arg0, &v15, v16), 16);
                0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::set_name(0x1::vector::borrow_mut<0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::Role>(arg1, v13), 0x1::string::utf8(b"none"));
                continue
            };
            if (v1 == 0x1::string::utf8(b"refresh")) {
                arg7 = arg7 - 2;
                v0 = v0 + 1;
            };
        };
        let v17 = 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::parse_lineup_str_vec(arg6, arg0, arg5, arg8, arg9);
        assert!(0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::role::check_roles_equal(arg1, 0x4ac91ed67c310ab3757a84347cf8c7d87ea1e85b4c689516bc901ebe09f36052::lineup::get_roles(&v17)), 18);
        assert!(arg7 == arg4, 19);
    }

    // decompiled from Move bytecode v6
}

