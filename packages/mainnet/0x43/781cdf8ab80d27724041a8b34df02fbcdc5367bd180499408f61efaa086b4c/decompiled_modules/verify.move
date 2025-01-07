module 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::verify {
    public fun verify_operation(arg0: &0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Global, arg1: &mut vector<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>, arg2: &mut vector<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>, arg3: vector<0x1::string::String>, arg4: u8, arg5: vector<0x1::string::String>, arg6: 0x1::string::String, arg7: u8, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        0x1::vector::reverse<0x1::string::String>(&mut arg3);
        while (0x1::vector::length<0x1::string::String>(&arg3) > 0) {
            let v1 = 0x1::vector::pop_back<0x1::string::String>(&mut arg3);
            if (v1 == 0x1::string::utf8(b"buy_upgrade")) {
                let (v2, v3) = 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::get_left_right_number(0x1::vector::pop_back<0x1::string::String>(&mut arg3));
                let v4 = *0x1::vector::borrow<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(arg2, v2 + 5 * v0);
                assert!(0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::get_class(&v4) != 0x1::string::utf8(b"none"), 9);
                let v5 = 0x1::vector::borrow_mut<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(arg1, v3);
                assert!(0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::get_class(v5) != 0x1::string::utf8(b"none"), 9);
                assert!(0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::upgrade(arg0, &v4, v5), 16);
                0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::set_class(0x1::vector::borrow_mut<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(arg2, v2), 0x1::string::utf8(b"none"));
                arg7 = arg7 - 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::get_gold_cost(&v4);
                continue
            };
            if (v1 == 0x1::string::utf8(b"buy")) {
                let (v6, v7) = 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::get_left_right_number(0x1::vector::pop_back<0x1::string::String>(&mut arg3));
                let v8 = 0x1::vector::borrow_mut<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(arg2, v6 + 5 * v0);
                assert!(0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::get_class(v8) != 0x1::string::utf8(b"none"), 9);
                let v9 = *v8;
                0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::set_class(v8, 0x1::string::utf8(b"none"));
                assert!(0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::get_class(0x1::vector::borrow<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(arg1, v7)) == 0x1::string::utf8(b"none"), 8);
                0x1::vector::remove<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(arg1, v7);
                0x1::vector::insert<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(arg1, v9, v7);
                arg7 = arg7 - 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::get_gold_cost(&v9);
                continue
            };
            if (v1 == 0x1::string::utf8(b"swap")) {
                let (v10, v11) = 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::get_left_right_number(0x1::vector::pop_back<0x1::string::String>(&mut arg3));
                0x1::vector::swap<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(arg1, v10, v11);
                continue
            };
            if (v1 == 0x1::string::utf8(b"sell")) {
                let v12 = 0x1::vector::borrow_mut<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(arg1, 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::utf8_to_u64(0x1::vector::pop_back<0x1::string::String>(&mut arg3)));
                assert!(0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::get_class(v12) != 0x1::string::utf8(b"none"), 8);
                0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::set_class(v12, 0x1::string::utf8(b"none"));
                arg7 = arg7 + 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::get_sell_gold_cost(v12);
                continue
            };
            if (v1 == 0x1::string::utf8(b"upgrade")) {
                let (v13, v14) = 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::get_left_right_number(0x1::vector::pop_back<0x1::string::String>(&mut arg3));
                assert!(v13 != v14, 17);
                let v15 = *0x1::vector::borrow<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(arg1, v13);
                assert!(0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::get_class(&v15) != 0x1::string::utf8(b"none"), 9);
                let v16 = 0x1::vector::borrow_mut<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(arg1, v14);
                assert!(0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::get_class(v16) != 0x1::string::utf8(b"none"), 9);
                assert!(0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::upgrade(arg0, &v15, v16), 16);
                0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::set_class(0x1::vector::borrow_mut<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(arg1, v13), 0x1::string::utf8(b"none"));
                continue
            };
            if (v1 == 0x1::string::utf8(b"refresh")) {
                arg7 = arg7 - 2;
                v0 = v0 + 1;
            };
        };
        let v17 = 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::lineup::parse_lineup_str_vec(arg6, arg0, arg5, arg8, arg9);
        assert!(0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::check_roles_equality(arg1, 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::lineup::get_roles(&v17)), 18);
        assert!(arg7 == arg4, 19);
    }

    // decompiled from Move bytecode v6
}

