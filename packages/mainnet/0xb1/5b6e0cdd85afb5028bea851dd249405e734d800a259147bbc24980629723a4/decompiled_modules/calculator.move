module 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::calculator {
    public fun calc_ve_sca(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        if (v0 >= arg1 || arg0 == 0) {
            0
        } else {
            let v2 = 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::util::mul_div(arg0, arg1 - v0, 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::constants::max_lock_duration());
            assert!(v2 > 0, 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::error_code::ve_sca_amount_overflow());
            v2
        }
    }

    public fun get_unlock_round_time(arg0: u64, arg1: &0x2::clock::Clock) : u64 {
        assert!(arg0 >= 1 && arg0 <= 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::constants::max_lock_rounds() - 1, 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::error_code::invalid_checkpoint_round());
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        v0 + 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::constants::unlock_round_duration() - v0 % 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::constants::unlock_round_duration() + 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::constants::unlock_round_duration() * arg0
    }

    public fun new_ve_sca_from_extending_lock(arg0: u64, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        assert!(arg2 > arg1, 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::error_code::extend_to_shorter_duration());
        calc_ve_sca(arg0, arg2, arg3) - calc_ve_sca(arg0, arg1, arg3)
    }

    // decompiled from Move bytecode v6
}

