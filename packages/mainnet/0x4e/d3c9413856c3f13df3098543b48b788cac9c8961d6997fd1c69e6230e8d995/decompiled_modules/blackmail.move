module 0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::blackmail {
    public(friend) fun calculate_cooldown(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = if (arg0 < arg1) {
            arg1
        } else if (arg0 > arg2) {
            arg2
        } else {
            arg0
        };
        arg3 + (v0 - arg1) * (arg4 - arg3) / (arg2 - arg1)
    }

    public fun calculate_heat_points(arg0: u128, arg1: bool) : u128 {
        if (arg1) {
            arg0 / 1000
        } else {
            0
        }
    }

    public(friend) fun calculate_level_point(arg0: vector<u64>, arg1: bool, arg2: u8) : u64 {
        let v0 = *0x1::vector::borrow<u64>(&arg0, 5);
        let v1 = v0;
        if (!arg1) {
            v1 = *0x1::vector::borrow<u64>(&arg0, 6);
        } else if (arg2 == 1) {
            v1 = v0 - *0x1::vector::borrow<u64>(&arg0, 1);
        } else if (arg2 == 2) {
            v1 = v0 + *0x1::vector::borrow<u64>(&arg0, 0);
        };
        0x1::u64::max(*0x1::vector::borrow<u64>(&arg0, 3), 0x1::u64::min(v1, *0x1::vector::borrow<u64>(&arg0, 4)))
    }

    public(friend) fun calculate_loot_percentage(arg0: vector<u64>, arg1: u8, arg2: u64, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) : (u64, vector<u64>) {
        let v0 = 0x2::random::new_generator(arg3, arg4);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x1::vector::empty<u64>();
        if (arg1 == 0) {
            v1 = *0x1::vector::borrow<u64>(&arg0, 4);
            v2 = *0x1::vector::borrow<u64>(&arg0, 5);
            0x1::vector::push_back<u64>(&mut v3, 4);
            0x1::vector::push_back<u64>(&mut v3, 5);
        } else if (arg1 == 1) {
            if (arg2 <= 2) {
                v1 = *0x1::vector::borrow<u64>(&arg0, 2);
                v2 = *0x1::vector::borrow<u64>(&arg0, 3);
                0x1::vector::push_back<u64>(&mut v3, 2);
                0x1::vector::push_back<u64>(&mut v3, 3);
            } else {
                v1 = *0x1::vector::borrow<u64>(&arg0, 0);
                v2 = *0x1::vector::borrow<u64>(&arg0, 1);
                0x1::vector::push_back<u64>(&mut v3, 0);
                0x1::vector::push_back<u64>(&mut v3, 1);
            };
        } else if (arg1 == 2) {
            if (arg2 <= 2) {
                v1 = *0x1::vector::borrow<u64>(&arg0, 6);
                v2 = *0x1::vector::borrow<u64>(&arg0, 7);
                0x1::vector::push_back<u64>(&mut v3, 6);
                0x1::vector::push_back<u64>(&mut v3, 7);
            } else {
                v1 = *0x1::vector::borrow<u64>(&arg0, 8);
                v2 = *0x1::vector::borrow<u64>(&arg0, 9);
                0x1::vector::push_back<u64>(&mut v3, 8);
                0x1::vector::push_back<u64>(&mut v3, 9);
            };
        };
        (0x2::random::generate_u64_in_range(&mut v0, v1, v2), v3)
    }

    public(friend) fun calculate_success_chance(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: &0x2::random::Random, arg10: &mut 0x2::tx_context::TxContext) : (u64, bool) {
        let v0 = arg2;
        if (arg0) {
            assert!(arg2 >= arg1, 0);
            v0 = arg2 - arg1;
        };
        if (arg7 == 1) {
            v0 = v0 + arg8 * arg4;
        };
        if (arg7 == 2) {
            assert!(v0 >= arg8 * arg3, 0);
            v0 = v0 - arg8 * arg3;
        };
        let v1 = 0x1::u64::max(0x1::u64::min(arg6, v0), arg5);
        (v1, flip_coin(arg9, v1, arg10))
    }

    public(friend) fun find_player_level_difference(arg0: u64, arg1: u64) : (u8, u64) {
        if (arg0 == arg1) {
            (0, 0)
        } else if (arg0 > arg1) {
            (1, arg0 - arg1)
        } else {
            (2, arg1 - arg0)
        }
    }

    public(friend) fun flip_coin(arg0: &0x2::random::Random, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::random::new_generator(arg0, arg2);
        0x2::random::generate_u64_in_range(&mut v0, 0, 100) <= arg1
    }

    public(friend) fun get_hidden_resource_match(arg0: u8, arg1: 0x1::string::String) : bool {
        arg0 == 1 && arg1 == 0x1::string::utf8(b"cash") || arg0 == 2 && arg1 == 0x1::string::utf8(b"weapon")
    }

    public(friend) fun get_loot_tag(arg0: u8, arg1: u64) : u8 {
        if (arg0 == 0) {
            0
        } else if (arg0 == 1) {
            if (arg1 >= 3) {
                1
            } else {
                2
            }
        } else if (arg1 >= 3) {
            4
        } else {
            3
        }
    }

    public(friend) fun process_blackmail(arg0: u128, arg1: u64) : u128 {
        let v0 = arg0 * (arg1 as u128) / 10000;
        if (v0 >= 1 * 0x1::u128::pow(2, 64)) {
            v0
        } else {
            0
        }
    }

    public fun record_blackmail(arg0: &0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::crimes_authority::CrimesCap, arg1: &0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::crimes_version::Version, arg2: u64, arg3: u64, arg4: &mut 0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::iblackmail::PlayerBlackmailInfo, arg5: &0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::iblackmail::PlayerBlackmailInfo, arg6: &0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::iblackmail::BlackmailType, arg7: &0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::iblackmail::BlackmailRegistry, arg8: u128, arg9: &0x2::random::Random, arg10: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, 0x1::string::String, u128, bool) {
        0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::crimes_version::validate_version(arg1);
        let v0 = 0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::iblackmail::borrow_blackmail_resource_type(arg6);
        let v1 = 0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::iblackmail::borrow_blackmail_registry(arg7);
        let (v2, v3) = find_player_level_difference(arg2, arg3);
        let (v4, v5) = calculate_success_chance(get_hidden_resource_match(0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::iblackmail::get_blackmail_defending_resource(arg5), v0), *0x1::vector::borrow<u64>(&v1, 4), *0x1::vector::borrow<u64>(&v1, 5), *0x1::vector::borrow<u64>(&v1, 6), *0x1::vector::borrow<u64>(&v1, 7), *0x1::vector::borrow<u64>(&v1, 8), *0x1::vector::borrow<u64>(&v1, 9), v2, v3, arg9, arg10);
        let (v6, v7) = if (v5) {
            let v8 = 0x1::vector::empty<u64>();
            let v9 = &mut v8;
            0x1::vector::push_back<u64>(v9, *0x1::vector::borrow<u64>(&v1, 16));
            0x1::vector::push_back<u64>(v9, *0x1::vector::borrow<u64>(&v1, 17));
            0x1::vector::push_back<u64>(v9, *0x1::vector::borrow<u64>(&v1, 18));
            0x1::vector::push_back<u64>(v9, *0x1::vector::borrow<u64>(&v1, 19));
            0x1::vector::push_back<u64>(v9, *0x1::vector::borrow<u64>(&v1, 20));
            0x1::vector::push_back<u64>(v9, *0x1::vector::borrow<u64>(&v1, 21));
            0x1::vector::push_back<u64>(v9, *0x1::vector::borrow<u64>(&v1, 22));
            0x1::vector::push_back<u64>(v9, *0x1::vector::borrow<u64>(&v1, 23));
            0x1::vector::push_back<u64>(v9, *0x1::vector::borrow<u64>(&v1, 24));
            0x1::vector::push_back<u64>(v9, *0x1::vector::borrow<u64>(&v1, 25));
            calculate_loot_percentage(v8, v2, v3, arg9, arg10)
        } else {
            let v10 = 0x1::vector::empty<u64>();
            let v11 = &mut v10;
            0x1::vector::push_back<u64>(v11, *0x1::vector::borrow<u64>(&v1, 16));
            0x1::vector::push_back<u64>(v11, *0x1::vector::borrow<u64>(&v1, 17));
            (0, v10)
        };
        let v12 = v7;
        let v13 = process_blackmail(arg8, v6);
        if (v5 && v13 >= 1 * 0x1::u128::pow(2, 64)) {
            0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::iblackmail::set_blackmail_success_count(arg4, 1);
        } else {
            0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::iblackmail::set_blackmail_failed_count(arg4, 1);
        };
        let v14 = 0x1::vector::empty<u64>();
        let v15 = &mut v14;
        0x1::vector::push_back<u64>(v15, *0x1::vector::borrow<u64>(&v1, 10));
        0x1::vector::push_back<u64>(v15, *0x1::vector::borrow<u64>(&v1, 11));
        0x1::vector::push_back<u64>(v15, *0x1::vector::borrow<u64>(&v1, 12));
        0x1::vector::push_back<u64>(v15, *0x1::vector::borrow<u64>(&v1, 13));
        0x1::vector::push_back<u64>(v15, *0x1::vector::borrow<u64>(&v1, 14));
        0x1::vector::push_back<u64>(v15, *0x1::vector::borrow<u64>(&v1, 15));
        0x1::vector::push_back<u64>(v15, *0x1::vector::borrow<u64>(&v1, 16));
        (calculate_cooldown(v4, *0x1::vector::borrow<u64>(&v12, 0), *0x1::vector::borrow<u64>(&v12, 1), *0x1::vector::borrow<u64>(&v1, 0), *0x1::vector::borrow<u64>(&v1, 1)), calculate_cooldown(v4, *0x1::vector::borrow<u64>(&v12, 0), *0x1::vector::borrow<u64>(&v12, 1), *0x1::vector::borrow<u64>(&v1, 2), *0x1::vector::borrow<u64>(&v1, 3)), calculate_level_point(v14, v5, v2), v0, v13, v5)
    }

    // decompiled from Move bytecode v6
}

