module 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::common {
    public(friend) fun assert_role_candidate_valid(arg0: address, arg1: address, arg2: address, arg3: address, arg4: &vector<address>, arg5: &vector<address>) {
        let v0 = if (arg0 != @0x0) {
            if (arg0 != arg1) {
                if (arg0 != arg2) {
                    if (arg0 != arg3) {
                        if (!0x1::vector::contains<address>(arg4, &arg0)) {
                            !0x1::vector::contains<address>(arg5, &arg0)
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6003);
    }

    public(friend) fun compute_platform_fee_delta(arg0: u128, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg3 <= arg2) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg0 == 0
        };
        if (v0) {
            return 0
        };
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::math::safe_cast_u256_to_u64((arg0 as u256) * (arg1 as u256) * ((arg3 - arg2) as u256) / (31536000000000000000 as u256))
    }

    public(friend) fun fee_denominator() : u128 {
        31536000000000000000
    }

    public(friend) fun update_accounts(arg0: &mut vector<address>, arg1: address, arg2: bool) {
        assert!(arg1 != @0x0, 6000);
        let (v0, v1) = 0x1::vector::index_of<address>(arg0, &arg1);
        if (arg2) {
            assert!(!v0, 6001);
            0x1::vector::push_back<address>(arg0, arg1);
        } else {
            assert!(v0, 6002);
            0x1::vector::remove<address>(arg0, v1);
        };
    }

    // decompiled from Move bytecode v7
}

