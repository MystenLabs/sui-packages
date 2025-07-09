module 0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::crack_safe {
    public(friend) fun borrow_allow_guess_hint(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        0x2::random::generate_bool(&mut v0)
    }

    public fun borrow_safe_bounds(arg0: &0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::icrack_safe::Safe) : vector<u64> {
        let v0 = 0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::icrack_safe::borrow_safe_information(arg0);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, *0x1::vector::borrow<u64>(&v0, 0));
        0x1::vector::push_back<u64>(v2, *0x1::vector::borrow<u64>(&v0, 1));
        v1
    }

    entry fun set_safe_config_value(arg0: &0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::crimes_authority::AdminCap, arg1: &mut 0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::icrack_safe::SafeRegistry, arg2: &0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::crimes_version::Version, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::crimes_version::validate_version(arg2);
        0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::icrack_safe::set_safe_configs(arg1, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun validate_guess(arg0: &0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::crimes_authority::CrimesCap, arg1: &0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::crimes_version::Version, arg2: &0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::icrack_safe::SafeRegistry, arg3: &mut 0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::icrack_safe::Safe, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: &0x2::random::Random, arg8: &mut 0x2::tx_context::TxContext) : 0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::icrack_safe::GuessEnum {
        0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::crimes_version::validate_version(arg1);
        if (arg5 == arg6) {
            0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::icrack_safe::reset_safe(arg3, arg2, arg4);
            0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::icrack_safe::guess_won()
        } else if (borrow_allow_guess_hint(arg7, arg8)) {
            let v1 = borrow_safe_bounds(arg3);
            let v2 = *0x1::vector::borrow<u64>(&v1, 0);
            let v3 = *0x1::vector::borrow<u64>(&v1, 1);
            let v0 = if (arg6 > arg5) {
                v2 = arg5;
                0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::icrack_safe::guess_higher()
            } else {
                v3 = arg5;
                0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::icrack_safe::guess_lower()
            };
            0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::icrack_safe::set_safe_bounds(arg3, v2, v3);
            v0
        } else {
            0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::icrack_safe::guess_failed()
        }
    }

    public fun validate_safe_closed(arg0: &0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::icrack_safe::Safe) {
        assert!(0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::icrack_safe::is_safe_closed(arg0), 1);
    }

    public fun validate_safe_cooldown(arg0: u64, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) > arg0, 0);
    }

    // decompiled from Move bytecode v6
}

