module 0xf877f864ef8fc69a09061785266118d935f540f62d4b5f628a6a1e1428e47b33::tmpp_anchor {
    struct ProofTimestamped has copy, drop {
        data_hash: vector<u8>,
        proof_id: vector<u8>,
        timestamp_ms: u64,
    }

    struct BatchTimestamped has copy, drop {
        batch_root: vector<u8>,
        storj_key: vector<u8>,
        proof_count: u64,
        timestamp_ms: u64,
    }

    public entry fun timestamp_batch(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 1);
        assert!(0x1::vector::length<u8>(&arg1) > 0, 2);
        assert!(arg2 > 0, 3);
        let v0 = BatchTimestamped{
            batch_root   : arg0,
            storj_key    : arg1,
            proof_count  : arg2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<BatchTimestamped>(v0);
    }

    public entry fun timestamp_proof(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 0);
        let v0 = ProofTimestamped{
            data_hash    : arg0,
            proof_id     : arg1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ProofTimestamped>(v0);
    }

    // decompiled from Move bytecode v6
}

