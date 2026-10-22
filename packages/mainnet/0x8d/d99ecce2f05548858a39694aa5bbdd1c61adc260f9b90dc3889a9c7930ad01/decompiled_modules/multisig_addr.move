module 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::multisig_addr {
    fun address_from_bytes(arg0: &vector<u8>, arg1: u8) : address {
        assert!(0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::pk_util::is_valid_key(arg0), 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::errors::invalid_public_key());
        assert!(*0x1::vector::borrow<u8>(arg0, 0) == arg1, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::errors::invalid_public_key());
        0x2::address::from_bytes(0x2::hash::blake2b256(arg0))
    }

    public fun derive_multisig_address(arg0: vector<vector<u8>>, arg1: vector<u8>, arg2: u16) : address {
        let v0 = 0x1::vector::length<vector<u8>>(&arg0);
        assert!(v0 == 0x1::vector::length<u8>(&arg1), 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::errors::multisig_lengths_mismatch());
        assert!(v0 > 0, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::errors::multisig_empty());
        assert!(v0 <= 10, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::errors::multisig_too_many_participants());
        let v1 = &arg0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(v1)) {
            0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::pk_util::assert_valid_key(0x1::vector::borrow<vector<u8>>(v1, v2));
            v2 = v2 + 1;
        };
        let v3 = &arg1;
        let v4 = 0;
        let v5;
        while (v4 < 0x1::vector::length<u8>(v3)) {
            if (!(*0x1::vector::borrow<u8>(v3, v4) > 0)) {
                v5 = false;
                /* label 13 */
                assert!(v5, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::errors::multisig_zero_weight());
                let v6 = 0;
                0x1::vector::reverse<u8>(&mut arg1);
                let v7 = 0;
                while (v7 < 0x1::vector::length<u8>(&arg1)) {
                    v6 = v6 + (0x1::vector::pop_back<u8>(&mut arg1) as u16);
                    v7 = v7 + 1;
                };
                0x1::vector::destroy_empty<u8>(arg1);
                assert!(arg2 > 0 && arg2 <= v6, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::errors::multisig_threshold_out_of_bounds());
                let v8 = &arg0;
                let v9 = 0x1::vector::length<vector<u8>>(v8);
                let v10 = 0;
                while (v10 < v9) {
                    let v11 = v10 + 1;
                    while (v11 < v9) {
                        assert!(!(0x1::vector::borrow<vector<u8>>(v8, v10) == 0x1::vector::borrow<vector<u8>>(v8, v11)), 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::errors::multisig_duplicate_public_key());
                        v11 = v11 + 1;
                    };
                    v10 = v10 + 1;
                };
                let v12 = 0x1::vector::empty<u8>();
                0x1::vector::push_back<u8>(&mut v12, 3);
                0x1::vector::append<u8>(&mut v12, 0x2::bcs::to_bytes<u16>(&arg2));
                let v13 = 0;
                while (v13 < v0) {
                    0x1::vector::append<u8>(&mut v12, *0x1::vector::borrow<vector<u8>>(&arg0, v13));
                    0x1::vector::push_back<u8>(&mut v12, *0x1::vector::borrow<u8>(&arg1, v13));
                    v13 = v13 + 1;
                };
                return 0x2::address::from_bytes(0x2::hash::blake2b256(&v12))
            };
            v4 = v4 + 1;
        };
        v5 = true;
        /* goto 13 */
    }

    public fun derive_policy_checked_address(arg0: vector<vector<u8>>, arg1: vector<u8>, arg2: u16) : address {
        assert!(0x1::vector::length<vector<u8>>(&arg0) >= 2, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::errors::multisig_not_enough_participants());
        let v0 = 0;
        0x1::vector::reverse<u8>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg1)) {
            let v2 = (0x1::vector::pop_back<u8>(&mut arg1) as u16);
            let v3 = if (v2 > v0) {
                v2
            } else {
                v0
            };
            v0 = v3;
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u8>(arg1);
        assert!(v0 < arg2, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::errors::multisig_single_signer_meets_threshold());
        let v4 = &arg0;
        let v5 = 0x1::vector::length<vector<u8>>(v4);
        let v6 = 0;
        while (v6 < v5) {
            let v7 = v6 + 1;
            while (v7 < v5) {
                assert!(!same_key_holder(0x1::vector::borrow<vector<u8>>(v4, v6), 0x1::vector::borrow<vector<u8>>(v4, v7)), 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::errors::multisig_duplicate_public_key());
                v7 = v7 + 1;
            };
            v6 = v6 + 1;
        };
        derive_multisig_address(arg0, arg1, arg2)
    }

    public fun ed25519_key_to_address(arg0: &vector<u8>) : address {
        address_from_bytes(arg0, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::pk_util::flag_ed25519())
    }

    public fun is_multisig_address(arg0: address, arg1: vector<vector<u8>>, arg2: vector<u8>, arg3: u16) : bool {
        derive_multisig_address(arg1, arg2, arg3) == arg0
    }

    public fun is_policy_checked_multisig_address(arg0: address, arg1: vector<vector<u8>>, arg2: vector<u8>, arg3: u16) : bool {
        derive_policy_checked_address(arg1, arg2, arg3) == arg0
    }

    public fun passkey_key_to_address(arg0: &vector<u8>) : address {
        address_from_bytes(arg0, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::pk_util::flag_passkey())
    }

    fun same_key_holder(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        if (arg0 == arg1) {
            return true
        };
        if (!0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::pk_util::is_p256_flag(*0x1::vector::borrow<u8>(arg0, 0)) || !0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::pk_util::is_p256_flag(*0x1::vector::borrow<u8>(arg1, 0))) {
            return false
        };
        let v0 = *arg0;
        let v1 = *arg1;
        *0x1::vector::borrow_mut<u8>(&mut v0, 0) = 0;
        *0x1::vector::borrow_mut<u8>(&mut v1, 0) = 0;
        v0 == v1
    }

    public fun secp256k1_key_to_address(arg0: &vector<u8>) : address {
        address_from_bytes(arg0, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::pk_util::flag_secp256k1())
    }

    public fun secp256r1_key_to_address(arg0: &vector<u8>) : address {
        address_from_bytes(arg0, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::pk_util::flag_secp256r1())
    }

    // decompiled from Move bytecode v7
}

