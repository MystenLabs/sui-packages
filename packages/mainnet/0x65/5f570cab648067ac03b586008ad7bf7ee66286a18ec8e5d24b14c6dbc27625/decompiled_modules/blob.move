module 0x655f570cab648067ac03b586008ad7bf7ee66286a18ec8e5d24b14c6dbc27625::blob {
    struct ParsedIntent has copy, drop {
        intent_id: vector<u8>,
        version: u8,
        dst_chain_id: u32,
        dst_token_hash: vector<u8>,
        dst_recipient: address,
        min_final_out: u64,
        deadline: u64,
    }

    fun be_u32(arg0: &vector<u8>, arg1: u64) : u32 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 4) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u32);
            v1 = v1 + 1;
        };
        v0
    }

    fun be_u64(arg0: &vector<u8>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u64);
            v1 = v1 + 1;
        };
        v0
    }

    public fun deadline(arg0: &ParsedIntent) : u64 {
        arg0.deadline
    }

    public fun dst_chain_id(arg0: &ParsedIntent) : u32 {
        arg0.dst_chain_id
    }

    public fun dst_recipient(arg0: &ParsedIntent) : address {
        arg0.dst_recipient
    }

    public fun dst_token_hash(arg0: &ParsedIntent) : vector<u8> {
        arg0.dst_token_hash
    }

    fun has_tag(arg0: &vector<u8>) : bool {
        let v0 = b"gum.uswap.v1";
        let v1 = 0;
        while (v1 < 12) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != *0x1::vector::borrow<u8>(&v0, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun intent_id(arg0: &ParsedIntent) : vector<u8> {
        arg0.intent_id
    }

    public fun min_final_out(arg0: &ParsedIntent) : u64 {
        arg0.min_final_out
    }

    public fun parse(arg0: vector<u8>) : ParsedIntent {
        let v0 = 0x1::vector::length<u8>(&arg0);
        assert!(v0 == 293 || v0 == 339, 1);
        assert!(has_tag(&arg0), 1);
        let v1 = *0x1::vector::borrow<u8>(&arg0, 12);
        let v2 = if (v1 == 1) {
            293
        } else {
            assert!(v1 == 2, 2);
            339
        };
        assert!(v0 == v2, 1);
        let v3 = 0;
        while (v3 < 24) {
            assert!(*0x1::vector::borrow<u8>(&arg0, 221 + v3) == 0, 3);
            v3 = v3 + 1;
        };
        ParsedIntent{
            intent_id      : 0x2::hash::keccak256(&arg0),
            version        : v1,
            dst_chain_id   : be_u32(&arg0, 153),
            dst_token_hash : slice(&arg0, 157, 32),
            dst_recipient  : 0x2::address::from_bytes(slice(&arg0, 189, 32)),
            min_final_out  : be_u64(&arg0, 221 + 24),
            deadline       : be_u64(&arg0, 253),
        }
    }

    fun slice(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun version(arg0: &ParsedIntent) : u8 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

