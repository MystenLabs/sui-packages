module 0x537b04d93d32682923cf748442866ee7b5428774ced2492ae042a0b6a4309db6::verify {
    public fun verify_operation(arg0: &0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Global, arg1: &mut vector<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>, arg2: &mut vector<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>, arg3: vector<0x1::string::String>, arg4: u8, arg5: vector<0x1::string::String>, arg6: 0x1::string::String, arg7: u8, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        0x1::vector::reverse<0x1::string::String>(&mut arg3);
        while (0x1::vector::length<0x1::string::String>(&arg3) > 0) {
            let v1 = 0x1::vector::pop_back<0x1::string::String>(&mut arg3);
            if (v1 == 0x1::string::utf8(b"buy_upgrade")) {
                let (v2, v3) = 0xd676f5b01f25ceace77b17fbbc91cbb2a5b43eea7695b99b32d15866f6a706d8::utils::get_left_right_number(0x1::vector::pop_back<0x1::string::String>(&mut arg3));
                assert!(0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg2) > v2 + 5 * v0, 7);
                let v4 = *0x1::vector::borrow<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg2, v2 + 5 * v0);
                assert!(0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_class(&v4) != 0x1::string::utf8(b"none"), 2);
                assert!(0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg1) > v3, 7);
                let v5 = 0x1::vector::borrow_mut<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg1, v3);
                assert!(0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_class(v5) != 0x1::string::utf8(b"none"), 2);
                assert!(0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::upgrade(arg0, &v4, v5), 3);
                0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::set_class(0x1::vector::borrow_mut<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg2, v2), 0x1::string::utf8(b"none"));
                arg7 = arg7 - 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_gold_cost(&v4);
                continue
            };
            if (v1 == 0x1::string::utf8(b"buy")) {
                let (v6, v7) = 0xd676f5b01f25ceace77b17fbbc91cbb2a5b43eea7695b99b32d15866f6a706d8::utils::get_left_right_number(0x1::vector::pop_back<0x1::string::String>(&mut arg3));
                assert!(0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg2) > v6 + 5 * v0, 7);
                let v8 = 0x1::vector::borrow_mut<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg2, v6 + 5 * v0);
                assert!(0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_class(v8) != 0x1::string::utf8(b"none"), 2);
                let v9 = *v8;
                0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::set_class(v8, 0x1::string::utf8(b"none"));
                assert!(0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg1) > v7, 7);
                assert!(0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_class(0x1::vector::borrow<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg1, v7)) == 0x1::string::utf8(b"none"), 1);
                0x1::vector::remove<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg1, v7);
                0x1::vector::insert<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg1, v9, v7);
                arg7 = arg7 - 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_gold_cost(&v9);
                continue
            };
            if (v1 == 0x1::string::utf8(b"swap")) {
                let (v10, v11) = 0xd676f5b01f25ceace77b17fbbc91cbb2a5b43eea7695b99b32d15866f6a706d8::utils::get_left_right_number(0x1::vector::pop_back<0x1::string::String>(&mut arg3));
                0x1::vector::swap<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg1, v10, v11);
                continue
            };
            if (v1 == 0x1::string::utf8(b"sell")) {
                let v12 = 0xd676f5b01f25ceace77b17fbbc91cbb2a5b43eea7695b99b32d15866f6a706d8::utils::utf8_to_u64(0x1::vector::pop_back<0x1::string::String>(&mut arg3));
                assert!(0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg1) > v12, 7);
                let v13 = 0x1::vector::borrow_mut<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg1, v12);
                assert!(0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_class(v13) != 0x1::string::utf8(b"none"), 1);
                0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::set_class(v13, 0x1::string::utf8(b"none"));
                arg7 = arg7 + 0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_sell_gold_cost(v13);
                continue
            };
            if (v1 == 0x1::string::utf8(b"upgrade")) {
                let (v14, v15) = 0xd676f5b01f25ceace77b17fbbc91cbb2a5b43eea7695b99b32d15866f6a706d8::utils::get_left_right_number(0x1::vector::pop_back<0x1::string::String>(&mut arg3));
                assert!(v14 != v15, 4);
                assert!(0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg1) > v14, 7);
                let v16 = *0x1::vector::borrow<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg1, v14);
                assert!(0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_class(&v16) != 0x1::string::utf8(b"none"), 2);
                assert!(0x1::vector::length<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg1) > v15, 7);
                let v17 = 0x1::vector::borrow_mut<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg1, v15);
                assert!(0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::get_class(v17) != 0x1::string::utf8(b"none"), 2);
                assert!(0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::upgrade(arg0, &v16, v17), 3);
                0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::set_class(0x1::vector::borrow_mut<0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::Role>(arg1, v14), 0x1::string::utf8(b"none"));
                continue
            };
            if (v1 == 0x1::string::utf8(b"refresh")) {
                arg7 = arg7 - 2;
                let v18 = v0 + 1;
                v0 = v18;
                if (v18 == 6) {
                    v0 = 0;
                };
            };
        };
        let v19 = 0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::parse_lineup_str_vec(arg6, arg0, arg5, arg8, arg9);
        assert!(0x4ef7d22f731621fcde258cc376f716127caf61d8dfa4c3fb96074643300097e9::role::check_roles_equality(arg1, 0x82b36157bea705ea46329400615d2c4e3540e498643475d7c7fa7fe47a308deb::lineup::get_roles(&v19)), 5);
        assert!(arg7 == arg4, 6);
    }

    // decompiled from Move bytecode v6
}

