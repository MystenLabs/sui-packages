module 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::valset_update {
    public(friend) fun check_validator_signatures(arg0: &0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::types::ValsetArgs, arg1: &vector<vector<u8>>, arg2: &vector<u8>) {
        let v0 = *arg1;
        let v1 = 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::types::validators(arg0);
        let v2 = 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::types::powers(arg0);
        assert!(0x1::vector::length<vector<u8>>(&v1) == 0x1::vector::length<vector<u8>>(&v0), 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::errors::err_unequal_length());
        let v3 = 0;
        let v4 = 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::signature_utils::make_digest(arg2);
        let v5 = 0;
        while (v5 < 0x1::vector::length<vector<u8>>(&v1)) {
            let v6 = 0x1::vector::borrow_mut<vector<u8>>(&mut v0, v5);
            let v7 = false;
            if (0x1::vector::length<u8>(v6) != 0) {
                v7 = 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::signature_utils::verify_sig(0x1::vector::borrow<vector<u8>>(&v1, v5), &v4, v6);
            };
            if (!v7) {
                v5 = v5 + 1;
                continue
            };
            let v8 = v3 + *0x1::vector::borrow<u64>(&v2, v5);
            v3 = v8;
            if (v8 > 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::constants::get_constant_power_threshold()) {
                break
            };
            v5 = v5 + 1;
        };
        assert!(v3 > 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::constants::get_constant_power_threshold(), 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::errors::err_insufficient_power());
    }

    public(friend) fun make_checkpoint(arg0: &0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::types::ValsetArgs) : vector<u8> {
        let v0 = 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::types::validators(arg0);
        let v1 = 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::types::powers(arg0);
        let v2 = if (0x1::vector::length<vector<u8>>(&v0) == 0x1::vector::length<u64>(&v1)) {
            let v3 = 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::types::powers(arg0);
            0x1::vector::length<u64>(&v3) != 0
        } else {
            false
        };
        assert!(v2, 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::errors::err_malformed_new_validator_set());
        let v4 = 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::types::validators(arg0);
        let v5 = 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::types::powers(arg0);
        let v6 = 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::types::valset_nonce(arg0);
        let v7 = 0x1::vector::empty<u8>();
        let v8 = 0x1::vector::empty<u8>();
        let v9 = 0;
        while (v9 < 0x1::vector::length<vector<u8>>(&v4)) {
            0x1::vector::append<u8>(&mut v7, 0x1::bcs::to_bytes<vector<u8>>(0x1::vector::borrow<vector<u8>>(&v4, v9)));
            0x1::vector::append<u8>(&mut v8, 0x1::bcs::to_bytes<u64>(0x1::vector::borrow<u64>(&v5, v9)));
            v9 = v9 + 1;
        };
        let v10 = 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::constants::get_check_point_method_name();
        0x1::vector::append<u8>(&mut v10, 0x1::bcs::to_bytes<u256>(&v6));
        0x1::vector::append<u8>(&mut v10, 0x1::bcs::to_bytes<vector<u8>>(&v7));
        0x1::vector::append<u8>(&mut v10, 0x1::bcs::to_bytes<vector<u8>>(&v8));
        0x2::hash::keccak256(&v10)
    }

    public(friend) fun validate_power(arg0: &0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::types::ValsetArgs) {
        let v0 = 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::types::powers(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v0)) {
            let v3 = v1 + *0x1::vector::borrow<u64>(&v0, v2);
            v1 = v3;
            if (v3 > 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::constants::get_constant_power_threshold()) {
                break
            };
            v2 = v2 + 1;
        };
        assert!(v1 > 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::constants::get_constant_power_threshold(), 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::errors::err_insufficient_power());
    }

    // decompiled from Move bytecode v6
}

