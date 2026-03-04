module 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::game_utils {
    public fun all_votes_equal(arg0: &vector<u32>) : bool {
        if (0x1::vector::length<u32>(arg0) <= 1) {
            return true
        };
        let v0 = 1;
        while (v0 < 0x1::vector::length<u32>(arg0)) {
            if (*0x1::vector::borrow<u32>(arg0, v0) != *0x1::vector::borrow<u32>(arg0, 0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun calculate_game_phase(arg0: u64, arg1: u64, arg2: u64) : u8 {
        if (arg0 < arg1) {
            0
        } else if (arg0 < arg2) {
            1
        } else {
            2
        }
    }

    public fun get_highest_votes(arg0: &vector<u32>) : u32 {
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u32>(arg0)) {
            let v3 = *0x1::vector::borrow<u32>(arg0, v2);
            if (v3 > v0) {
                v1 = v3;
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_max_walrus_epochs_ahead() : u64 {
        52
    }

    public(friend) fun safe_add_u64(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 106);
        arg0 + arg1
    }

    public fun safe_elapsed_time(arg0: u64, arg1: u64) : u64 {
        if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    public(friend) fun safe_multiply_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg0 <= 18446744073709551615 / arg1, 106);
        arg0 * arg1
    }

    public fun sum_votes(arg0: &vector<u32>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u32>(arg0)) {
            v0 = v0 + (*0x1::vector::borrow<u32>(arg0, v1) as u64);
            v1 = v1 + 1;
        };
        v0
    }

    public fun u64_to_ascii(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public(friend) fun validate_bid_amount(arg0: u64) {
        assert!(arg0 > 0, 106);
        assert!(arg0 <= 1000000000000000000, 106);
    }

    public(friend) fun validate_blob_for_target_epoch(arg0: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg1: u32, arg2: u64, arg3: u64) {
        validate_blob_lifetime(arg0, arg1);
        assert!((0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(arg0) as u64) >= (arg1 as u64) + ((arg3 - arg2) * 1 + 14 - 1) / 14, 109);
    }

    public(friend) fun validate_blob_lifetime(arg0: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg1: u32) {
        assert!(0x1::option::is_some<u32>(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::certified_epoch(arg0)), 103);
        assert!(((0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(arg0) - 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::start_epoch(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::storage(arg0))) as u64) == 52, 104);
        assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::start_epoch(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::storage(arg0)) >= arg1, 105);
    }

    public(friend) fun validate_size_bounds(arg0: u64) {
        assert!(arg0 > 0, 106);
        assert!(arg0 <= 104857600, 106);
    }

    public(friend) fun validate_target_epoch(arg0: u64, arg1: u64) {
        assert!(arg1 > arg0, 100);
        assert!(((arg1 - arg0) * 1 + 14 - 1) / 14 + 1 <= 52, 101);
    }

    public(friend) fun validate_treasury_operation(arg0: u64, arg1: u64, arg2: bool) : u64 {
        if (arg2) {
            safe_add_u64(arg0, arg1)
        } else {
            assert!(arg0 >= arg1, 108);
            arg0 - arg1
        }
    }

    public(friend) fun validate_user_vote_count(arg0: u64) {
        assert!(arg0 < 1024, 107);
    }

    // decompiled from Move bytecode v6
}

