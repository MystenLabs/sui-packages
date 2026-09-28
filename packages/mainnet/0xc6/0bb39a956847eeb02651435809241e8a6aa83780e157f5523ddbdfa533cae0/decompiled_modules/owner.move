module 0xc60bb39a956847eeb02651435809241e8a6aa83780e157f5523ddbdfa533cae0::owner {
    struct Owner has copy, drop, store {
        chain: u8,
        address: vector<u8>,
    }

    public fun addr(arg0: &Owner) : vector<u8> {
        arg0.address
    }

    public fun approves_footer(arg0: &Owner, arg1: &vector<u8>, arg2: &vector<u8>, arg3: &vector<u8>) : bool {
        ends_with(arg1, arg3) && signed(arg0, arg1, arg2)
    }

    public fun binding_payload(arg0: &Owner, arg1: vector<u8>, arg2: &vector<u8>) : vector<u8> {
        let v0 = x"496b61204163636f756e7473206f776e65720a52656769737472793a203078";
        0x1::vector::append<u8>(&mut v0, 0x2::hex::encode(arg1));
        0x1::vector::append<u8>(&mut v0, x"0a4f776e65723a20");
        0x1::vector::append<u8>(&mut v0, decimal((arg0.chain as u64)));
        0x1::vector::append<u8>(&mut v0, b":0x");
        0x1::vector::append<u8>(&mut v0, 0x2::hex::encode(arg0.address));
        0x1::vector::append<u8>(&mut v0, x"0a53657373696f6e3a203078");
        0x1::vector::append<u8>(&mut v0, 0x2::hex::encode(*arg2));
        v0
    }

    public fun chain(arg0: &Owner) : u8 {
        arg0.chain
    }

    fun decimal(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = b"";
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public fun end_session_footer(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : vector<u8> {
        let v0 = x"0a496b612072656769737472793a203078";
        0x1::vector::append<u8>(&mut v0, 0x2::hex::encode(arg0));
        0x1::vector::append<u8>(&mut v0, x"0a496b61206457616c6c65743a203078");
        0x1::vector::append<u8>(&mut v0, 0x2::hex::encode(arg1));
        0x1::vector::append<u8>(&mut v0, x"0a456e642073657373696f6e3a203078");
        0x1::vector::append<u8>(&mut v0, 0x2::hex::encode(arg2));
        v0
    }

    fun ends_with(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        if (v1 > v0) {
            return false
        };
        let v2 = 0;
        while (v2 < v1) {
            if (*0x1::vector::borrow<u8>(arg0, v0 - v1 + v2) != *0x1::vector::borrow<u8>(arg1, v2)) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    public fun footer(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &vector<u8>) : vector<u8> {
        let v0 = x"0a496b612072656769737472793a203078";
        0x1::vector::append<u8>(&mut v0, 0x2::hex::encode(arg0));
        0x1::vector::append<u8>(&mut v0, x"0a496b6120");
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, b": 0x");
        0x1::vector::append<u8>(&mut v0, 0x2::hex::encode(arg2));
        0x1::vector::append<u8>(&mut v0, x"0a5369676e696e673a20");
        0x1::vector::append<u8>(&mut v0, 0x2::hex::encode(0x1::hash::sha2_256(*arg3)));
        v0
    }

    public fun new(arg0: u8, arg1: vector<u8>) : Owner {
        assert!(arg0 == 0 && 0x1::vector::length<u8>(&arg1) == 20 || arg0 == 1 && 0x1::vector::length<u8>(&arg1) == 32, 100);
        Owner{
            chain   : arg0,
            address : arg1,
        }
    }

    public fun session_lines(arg0: vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = x"0a53657373696f6e206b65793a203078";
        0x1::vector::append<u8>(&mut v0, 0x2::hex::encode(arg0));
        0x1::vector::append<u8>(&mut v0, x"0a53657373696f6e20756e74696c3a20");
        0x1::vector::append<u8>(&mut v0, decimal(arg1));
        0x1::vector::append<u8>(&mut v0, x"0a53657373696f6e207369676e6174757265733a20");
        0x1::vector::append<u8>(&mut v0, decimal(arg2));
        v0
    }

    public fun session_payload(arg0: vector<u8>, arg1: vector<u8>, arg2: &vector<u8>) : vector<u8> {
        let v0 = x"496b61204163636f756e74732073657373696f6e0a52656769737472793a203078";
        0x1::vector::append<u8>(&mut v0, 0x2::hex::encode(arg0));
        0x1::vector::append<u8>(&mut v0, x"0a6457616c6c65743a203078");
        0x1::vector::append<u8>(&mut v0, 0x2::hex::encode(arg1));
        0x1::vector::append<u8>(&mut v0, x"0a5369676e696e673a20");
        0x1::vector::append<u8>(&mut v0, 0x2::hex::encode(0x1::hash::sha2_256(*arg2)));
        v0
    }

    public fun signed(arg0: &Owner, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        if (arg0.chain == 1) {
            return 0x1::vector::length<u8>(arg2) == 64 && 0x2::ed25519::ed25519_verify(arg2, &arg0.address, arg1)
        };
        if (0x1::vector::length<u8>(arg2) != 65) {
            return false
        };
        let v0 = *arg2;
        let v1 = *0x1::vector::borrow<u8>(&v0, 64);
        let v2 = if (v1 >= 27) {
            v1 - 27
        } else {
            v1
        };
        if (v2 > 1) {
            return false
        };
        *0x1::vector::borrow_mut<u8>(&mut v0, 64) = v2;
        let v3 = x"19457468657265756d205369676e6564204d6573736167653a0a";
        0x1::vector::append<u8>(&mut v3, decimal(0x1::vector::length<u8>(arg1)));
        0x1::vector::append<u8>(&mut v3, *arg1);
        let v4 = 0x2::ecdsa_k1::secp256k1_ecrecover(&v0, &v3, 0);
        let v5 = 0x2::ecdsa_k1::decompress_pubkey(&v4);
        let v6 = b"";
        let v7 = 1;
        while (v7 < 65) {
            0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&v5, v7));
            v7 = v7 + 1;
        };
        let v8 = 0x2::hash::keccak256(&v6);
        let v9 = 0;
        while (v9 < 20) {
            if (*0x1::vector::borrow<u8>(&v8, 12 + v9) != *0x1::vector::borrow<u8>(&arg0.address, v9)) {
                return false
            };
            v9 = v9 + 1;
        };
        true
    }

    // decompiled from Move bytecode v7
}

