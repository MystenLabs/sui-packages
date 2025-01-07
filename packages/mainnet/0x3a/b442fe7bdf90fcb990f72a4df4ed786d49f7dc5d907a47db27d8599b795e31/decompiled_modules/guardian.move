module 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::guardian {
    struct Guardian has store {
        pubkey: 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes20::Bytes20,
    }

    public fun new(arg0: vector<u8>) : Guardian {
        let v0 = 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes20::new(arg0);
        assert!(0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes20::is_nonzero(&v0), 1);
        Guardian{pubkey: v0}
    }

    public fun as_bytes(arg0: &Guardian) : vector<u8> {
        0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes20::data(&arg0.pubkey)
    }

    fun ecrecover(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x2::ecdsa_k1::secp256k1_ecrecover(&arg1, &arg0, 0);
        let v1 = 0x2::ecdsa_k1::decompress_pubkey(&v0);
        0x1::vector::remove<u8>(&mut v1, 0);
        let v2 = 0x2::hash::keccak256(&v1);
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 0;
        while (v4 < 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes20::length()) {
            0x1::vector::push_back<u8>(&mut v3, 0x1::vector::pop_back<u8>(&mut v2));
            v4 = v4 + 1;
        };
        0x1::vector::reverse<u8>(&mut v3);
        v3
    }

    public fun pubkey(arg0: &Guardian) : 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::bytes20::Bytes20 {
        arg0.pubkey
    }

    public fun verify(arg0: &Guardian, arg1: 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::guardian_signature::GuardianSignature, arg2: vector<u8>) : bool {
        as_bytes(arg0) == ecrecover(arg2, 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::guardian_signature::to_rsv(arg1))
    }

    // decompiled from Move bytecode v6
}

