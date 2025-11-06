module 0x79dbf3fd342e7795388012fb2f56e447e0c34d4f3297f74ff2804d00ab46d74b::quest_marker {
    struct DigestSubmitted has copy, drop, store {
        slug: vector<u8>,
        digest_b64: vector<u8>,
        session_nonce: vector<u8>,
        sender: address,
    }

    public entry fun submit_digest(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u8>(&arg0);
        assert!(v0 > 0 && v0 <= 64, 0);
        let v1 = 0x1::vector::length<u8>(&arg1);
        assert!(v1 >= 32 && v1 <= 4096, 1);
        let v2 = 0x1::vector::length<u8>(&arg2);
        assert!(v2 >= 16 && v2 <= 64, 2);
        let v3 = DigestSubmitted{
            slug          : arg0,
            digest_b64    : arg1,
            session_nonce : arg2,
            sender        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<DigestSubmitted>(v3);
    }

    // decompiled from Move bytecode v6
}

