module 0xd3a2960aaf137bf5c47680304ff07c0ea159b62a37fd315dac57bdcd14af1cb2::payload {
    struct SealPayload has copy, drop, store {
        source_chain: u16,
        nft_contract: vector<u8>,
        token_id: vector<u8>,
        deposit_address: vector<u8>,
        receiver: vector<u8>,
        token_uri: vector<u8>,
    }

    public fun chain_name(arg0: u16) : vector<u8> {
        if (arg0 == 1) {
            return b"solana"
        };
        if (arg0 == 2) {
            return b"ethereum"
        };
        if (arg0 == 4) {
            return b"bsc"
        };
        if (arg0 == 5) {
            return b"polygon"
        };
        if (arg0 == 6) {
            return b"avalanche"
        };
        if (arg0 == 15) {
            return b"near"
        };
        if (arg0 == 21) {
            return b"sui"
        };
        if (arg0 == 22) {
            return b"aptos"
        };
        if (arg0 == 23) {
            return b"arbitrum"
        };
        if (arg0 == 24) {
            return b"optimism"
        };
        if (arg0 == 30) {
            return b"base"
        };
        b"unkown"
    }

    public fun construct_signing_message(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x1::vector::append<u8>(&mut v0, *arg1);
        0x1::vector::append<u8>(&mut v0, *arg2);
        0x1::hash::sha2_256(v0)
    }

    public fun decode_seal_payload(arg0: &vector<u8>) : SealPayload {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 >= 131, 1);
        assert!(*0x1::vector::borrow<u8>(arg0, 0) == 1, 2);
        let v1 = (*0x1::vector::borrow<u8>(arg0, 1) as u16) << 8 | (*0x1::vector::borrow<u8>(arg0, 2) as u16);
        assert!(is_supported_chain(v1), 3);
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 3;
        while (v3 < 35) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(arg0, v3));
            v3 = v3 + 1;
        };
        let v4 = 0x1::vector::empty<u8>();
        v3 = 35;
        while (v3 < 67) {
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg0, v3));
            v3 = v3 + 1;
        };
        let v5 = if (is_evm_chain(v1)) {
            79
        } else {
            67
        };
        let v6 = 0x1::vector::empty<u8>();
        v3 = v5;
        while (v3 < 99) {
            0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(arg0, v3));
            v3 = v3 + 1;
        };
        let v7 = 0x1::vector::empty<u8>();
        v3 = 99;
        while (v3 < 131) {
            0x1::vector::push_back<u8>(&mut v7, *0x1::vector::borrow<u8>(arg0, v3));
            v3 = v3 + 1;
        };
        let v8 = 0x1::vector::empty<u8>();
        v3 = 131;
        while (v3 < v0) {
            0x1::vector::push_back<u8>(&mut v8, *0x1::vector::borrow<u8>(arg0, v3));
            v3 = v3 + 1;
        };
        SealPayload{
            source_chain    : v1,
            nft_contract    : v2,
            token_id        : v4,
            deposit_address : v6,
            receiver        : v7,
            token_uri       : v8,
        }
    }

    public fun encode_seal_payload(arg0: u16, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 1);
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 & 255) as u8));
        let v1 = 0x1::vector::length<u8>(&arg1);
        let v2 = 0;
        while (v2 < 32 - v1) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v2 = v2 + 1;
        };
        v2 = 0;
        while (v2 < v1) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg1, v2));
            v2 = v2 + 1;
        };
        let v3 = 0x1::vector::length<u8>(&arg2);
        v2 = 0;
        while (v2 < 32 - v3) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v2 = v2 + 1;
        };
        v2 = 0;
        while (v2 < v3) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg2, v2));
            v2 = v2 + 1;
        };
        let v4 = 0x1::vector::length<u8>(&arg3);
        v2 = 0;
        while (v2 < 32 - v4) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v2 = v2 + 1;
        };
        v2 = 0;
        while (v2 < v4) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg3, v2));
            v2 = v2 + 1;
        };
        let v5 = 0x1::vector::length<u8>(&arg4);
        v2 = 0;
        while (v2 < 32 - v5) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v2 = v2 + 1;
        };
        v2 = 0;
        while (v2 < v5) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg4, v2));
            v2 = v2 + 1;
        };
        0x1::vector::append<u8>(&mut v0, arg5);
        v0
    }

    public fun get_deposit_address(arg0: &SealPayload) : &vector<u8> {
        &arg0.deposit_address
    }

    public fun get_nft_contract(arg0: &SealPayload) : &vector<u8> {
        &arg0.nft_contract
    }

    public fun get_receiver(arg0: &SealPayload) : &vector<u8> {
        &arg0.receiver
    }

    public fun get_source_chain(arg0: &SealPayload) : u16 {
        arg0.source_chain
    }

    public fun get_token_id(arg0: &SealPayload) : &vector<u8> {
        &arg0.token_id
    }

    public fun get_token_uri(arg0: &SealPayload) : &vector<u8> {
        &arg0.token_uri
    }

    public fun is_evm_chain(arg0: u16) : bool {
        if (arg0 == 2) {
            true
        } else if (arg0 == 4) {
            true
        } else if (arg0 == 5) {
            true
        } else if (arg0 == 6) {
            true
        } else if (arg0 == 23) {
            true
        } else if (arg0 == 24) {
            true
        } else if (arg0 == 30) {
            true
        } else if (arg0 == 10002) {
            true
        } else if (arg0 == 10003) {
            true
        } else if (arg0 == 10004) {
            true
        } else {
            arg0 == 10005
        }
    }

    public fun is_supported_chain(arg0: u16) : bool {
        if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 4) {
            true
        } else if (arg0 == 5) {
            true
        } else if (arg0 == 6) {
            true
        } else if (arg0 == 15) {
            true
        } else if (arg0 == 21) {
            true
        } else if (arg0 == 22) {
            true
        } else if (arg0 == 23) {
            true
        } else if (arg0 == 24) {
            true
        } else if (arg0 == 30) {
            true
        } else if (arg0 == 10002) {
            true
        } else if (arg0 == 10003) {
            true
        } else if (arg0 == 10004) {
            true
        } else {
            arg0 == 10005
        }
    }

    // decompiled from Move bytecode v6
}

