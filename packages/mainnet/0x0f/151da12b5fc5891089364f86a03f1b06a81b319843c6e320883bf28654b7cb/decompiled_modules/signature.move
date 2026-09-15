module 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature {
    public fun ed25519() : u8 {
        0
    }

    public fun bls12381_min_pk() : u8 {
        2
    }

    public fun bls12381_min_sig() : u8 {
        1
    }

    public fun is_valid_public_key_length(arg0: u8, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg1);
        arg0 == 0 && v0 == 32 || arg0 == 1 && v0 == 96 || arg0 == 2 && v0 == 48 || arg0 == 3 && (v0 == 33 || v0 == 65)
    }

    fun is_valid_signature_length(arg0: u8, arg1: &vector<u8>) : bool {
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

    public fun secp256k1() : u8 {
        3
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
        assert!(is_valid_signature_type(arg0), 13906834792818933765);
        assert!(is_valid_public_key_length(arg0, arg1), 13906834797113769987);
        assert!(is_valid_signature_length(arg0, arg3), 13906834801408606209);
        arg0 == 0 && verify_ed25519_internal(arg1, arg2, arg3) || arg0 == 1 && verify_bls12381_min_sig_internal(arg1, arg2, arg3) || arg0 == 2 && verify_bls12381_min_pk_internal(arg1, arg2, arg3) || arg0 == 3 && verify_secp256k1_internal(arg1, arg2, arg3, 1)
    }

    fun verify_bls12381_min_pk_internal(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        0x2::bls12381::bls12381_min_pk_verify(arg2, arg0, arg1)
    }

    fun verify_bls12381_min_sig_internal(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        0x2::bls12381::bls12381_min_sig_verify(arg2, arg0, arg1)
    }

    fun verify_ed25519_internal(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        0x2::ed25519::ed25519_verify(arg2, arg0, arg1)
    }

    fun verify_secp256k1_internal(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u8) : bool {
        0x2::ecdsa_k1::secp256k1_verify(arg2, arg0, arg1, arg3)
    }

    // decompiled from Move bytecode v7
}

