module 0x780edae529df1c443a6d638af70e0c790cf3b42f529d02bb911fcbe2498b4ce5::signature {
    public fun ed25519() : u8 {
        0
    }

    public fun be_bytes_to_u64(arg0: &vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(arg0) >= 8, 13906836016884350977);
        (*0x1::vector::borrow<u8>(arg0, 0) as u64) << 56 | (*0x1::vector::borrow<u8>(arg0, 1) as u64) << 48 | (*0x1::vector::borrow<u8>(arg0, 2) as u64) << 40 | (*0x1::vector::borrow<u8>(arg0, 3) as u64) << 32 | (*0x1::vector::borrow<u8>(arg0, 4) as u64) << 24 | (*0x1::vector::borrow<u8>(arg0, 5) as u64) << 16 | (*0x1::vector::borrow<u8>(arg0, 6) as u64) << 8 | (*0x1::vector::borrow<u8>(arg0, 7) as u64)
    }

    public fun bls12381_min_pk() : u8 {
        2
    }

    public fun bls12381_min_sig() : u8 {
        1
    }

    public fun concat_bytes(arg0: vector<vector<u8>>) : vector<u8> {
        let v0 = b"";
        let v1 = &arg0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(v1)) {
            0x1::vector::append<u8>(&mut v0, *0x1::vector::borrow<vector<u8>>(v1, v2));
            v2 = v2 + 1;
        };
        v0
    }

    public fun create_domain_separated_message(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::length<u8>(&arg0);
        assert!(v0 <= 255, 13906835806430953473);
        let v1 = b"";
        0x1::vector::push_back<u8>(&mut v1, (v0 as u8));
        0x1::vector::append<u8>(&mut v1, arg0);
        0x1::vector::append<u8>(&mut v1, arg1);
        v1
    }

    public fun create_tunnel_message(arg0: vector<u8>, arg1: u64, arg2: vector<u8>) : vector<u8> {
        let v0 = b"sui_tunnel::signature::message";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, u64_to_be_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, arg2);
        v0
    }

    public fun hash_keccak256() : u8 {
        0
    }

    public fun hash_message(arg0: &vector<u8>) : vector<u8> {
        0x2::hash::blake2b256(arg0)
    }

    public fun hash_sha256() : u8 {
        1
    }

    public fun is_valid_public_key_length(arg0: u8, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg1);
        arg0 == 0 && v0 == 32 || arg0 == 1 && v0 == 96 || arg0 == 2 && v0 == 48 || arg0 == 3 && (v0 == 33 || v0 == 65)
    }

    public fun is_valid_signature_length(arg0: u8, arg1: &vector<u8>) : bool {
        arg0 == 0 && 0x1::vector::length<u8>(arg1) == 64 || arg0 == 1 && 0x1::vector::length<u8>(arg1) == 48 || arg0 == 2 && 0x1::vector::length<u8>(arg1) == 96 || arg0 == 3 && 0x1::vector::length<u8>(arg1) == 64
    }

    public fun is_valid_signature_type(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else {
            arg0 == 3
        }
    }

    public fun public_key_size(arg0: u8) : u64 {
        if (arg0 == 0) {
            32
        } else if (arg0 == 1) {
            96
        } else if (arg0 == 2) {
            48
        } else {
            assert!(arg0 == 3, 13906834870128476167);
            33
        }
    }

    public fun secp256k1() : u8 {
        3
    }

    public fun signature_size(arg0: u8) : u64 {
        if (arg0 == 0) {
            64
        } else if (arg0 == 1) {
            48
        } else if (arg0 == 2) {
            96
        } else {
            assert!(arg0 == 3, 13906834801408999431);
            64
        }
    }

    public fun u64_to_be_bytes(arg0: u64) : vector<u8> {
        let v0 = b"";
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 56 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 48 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 40 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 32 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 & 255) as u8));
        v0
    }

    public fun verify(arg0: u8, arg1: &vector<u8>, arg2: &vector<u8>, arg3: &vector<u8>) : bool {
        assert!(is_valid_signature_type(arg0), 13906835157891284999);
        assert!(is_valid_public_key_length(arg0, arg1), 13906835170776055813);
        assert!(is_valid_signature_length(arg0, arg3), 13906835175070892035);
        arg0 == 0 && verify_ed25519_internal(arg1, arg2, arg3) || arg0 == 1 && verify_bls12381_min_sig_internal(arg1, arg2, arg3) || arg0 == 2 && verify_bls12381_min_pk_internal(arg1, arg2, arg3) || arg0 == 3 && verify_secp256k1_internal(arg1, arg2, arg3, 1)
    }

    public fun verify_bls12381_min_pk(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        assert!(0x1::vector::length<u8>(arg0) == 48, 13906835497193570309);
        assert!(0x1::vector::length<u8>(arg2) == 96, 13906835501488406531);
        verify_bls12381_min_pk_internal(arg0, arg1, arg2)
    }

    fun verify_bls12381_min_pk_internal(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        0x2::bls12381::bls12381_min_pk_verify(arg2, arg0, arg1)
    }

    public fun verify_bls12381_min_sig(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        assert!(0x1::vector::length<u8>(arg0) == 96, 13906835441358995461);
        assert!(0x1::vector::length<u8>(arg2) == 48, 13906835445653831683);
        verify_bls12381_min_sig_internal(arg0, arg1, arg2)
    }

    fun verify_bls12381_min_sig_internal(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        0x2::bls12381::bls12381_min_sig_verify(arg2, arg0, arg1)
    }

    public fun verify_ed25519(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        assert!(0x1::vector::length<u8>(arg0) == 32, 13906835385524420613);
        assert!(0x1::vector::length<u8>(arg2) == 64, 13906835389819256835);
        verify_ed25519_internal(arg0, arg1, arg2)
    }

    fun verify_ed25519_internal(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        0x2::ed25519::ed25519_verify(arg2, arg0, arg1)
    }

    public fun verify_secp256k1(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u8) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 == 33 || v0 == 65, 13906835574502981637);
        assert!(0x1::vector::length<u8>(arg2) == 64, 13906835591682719747);
        verify_secp256k1_internal(arg0, arg1, arg2, arg3)
    }

    fun verify_secp256k1_internal(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u8) : bool {
        0x2::ecdsa_k1::secp256k1_verify(arg2, arg0, arg1, arg3)
    }

    public fun verify_with_hash(arg0: u8, arg1: &vector<u8>, arg2: &vector<u8>, arg3: &vector<u8>, arg4: u8) : bool {
        if (arg0 != 3) {
            return verify(arg0, arg1, arg2, arg3)
        };
        assert!(is_valid_signature_type(arg0), 13906835308215140359);
        assert!(is_valid_public_key_length(arg0, arg1), 13906835312509976581);
        assert!(is_valid_signature_length(arg0, arg3), 13906835316804812803);
        verify_secp256k1_internal(arg1, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v7
}

