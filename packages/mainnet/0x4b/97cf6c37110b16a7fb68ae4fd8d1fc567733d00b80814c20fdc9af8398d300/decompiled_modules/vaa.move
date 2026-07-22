module 0x4b97cf6c37110b16a7fb68ae4fd8d1fc567733d00b80814c20fdc9af8398d300::vaa {
    struct Signature has copy, drop, store {
        guardian_index: u8,
        sig: vector<u8>,
    }

    struct Vaa has copy, drop, store {
        guardian_set_index: u32,
        signatures: vector<Signature>,
        body: vector<u8>,
        emitter_chain: u16,
        emitter_address: vector<u8>,
        sequence: u64,
        payload: vector<u8>,
    }

    public fun emitter_address(arg0: &Vaa) : vector<u8> {
        arg0.emitter_address
    }

    public fun emitter_chain(arg0: &Vaa) : u16 {
        arg0.emitter_chain
    }

    fun eth_address(arg0: &vector<u8>) : vector<u8> {
        let v0 = slice(arg0, 1, 65);
        let v1 = 0x2::hash::keccak256(&v0);
        slice(&v1, 12, 32)
    }

    public fun guardian_set_index(arg0: &Vaa) : u32 {
        arg0.guardian_set_index
    }

    public fun parse(arg0: vector<u8>) : Vaa {
        assert!(0x1::vector::length<u8>(&arg0) >= 6, 1);
        let v0 = 6;
        let v1 = 0x1::vector::empty<Signature>();
        let v2 = 0;
        while (v2 < (*0x1::vector::borrow<u8>(&arg0, 5) as u64)) {
            let v3 = Signature{
                guardian_index : *0x1::vector::borrow<u8>(&arg0, v0),
                sig            : slice(&arg0, v0 + 1, v0 + 66),
            };
            0x1::vector::push_back<Signature>(&mut v1, v3);
            v0 = v0 + 66;
            v2 = v2 + 1;
        };
        let v4 = slice(&arg0, v0, 0x1::vector::length<u8>(&arg0));
        Vaa{
            guardian_set_index : read_u32_be(&arg0, 1),
            signatures         : v1,
            body               : v4,
            emitter_chain      : read_u16_be(&v4, 8),
            emitter_address    : slice(&v4, 10, 42),
            sequence           : read_u64_be(&v4, 42),
            payload            : slice(&v4, 51, 0x1::vector::length<u8>(&v4)),
        }
    }

    public fun payload(arg0: &Vaa) : vector<u8> {
        arg0.payload
    }

    public fun payload_amount(arg0: &Vaa) : u64 {
        read_u64_be(&arg0.payload, 0)
    }

    public fun payload_dest(arg0: &Vaa) : vector<u8> {
        slice(&arg0.payload, 8, 0x1::vector::length<u8>(&arg0.payload))
    }

    public fun payload_dest8(arg0: &Vaa) : vector<u8> {
        slice(&arg0.payload, 8, 16)
    }

    public fun payload_source_token(arg0: &Vaa) : vector<u8> {
        slice(&arg0.payload, 16, 36)
    }

    fun read_u16_be(arg0: &vector<u8>, arg1: u64) : u16 {
        (*0x1::vector::borrow<u8>(arg0, arg1) as u16) << 8 | (*0x1::vector::borrow<u8>(arg0, arg1 + 1) as u16)
    }

    fun read_u32_be(arg0: &vector<u8>, arg1: u64) : u32 {
        (*0x1::vector::borrow<u8>(arg0, arg1) as u32) << 24 | (*0x1::vector::borrow<u8>(arg0, arg1 + 1) as u32) << 16 | (*0x1::vector::borrow<u8>(arg0, arg1 + 2) as u32) << 8 | (*0x1::vector::borrow<u8>(arg0, arg1 + 3) as u32)
    }

    fun read_u64_be(arg0: &vector<u8>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u64);
            v1 = v1 + 1;
        };
        v0
    }

    public fun sequence(arg0: &Vaa) : u64 {
        arg0.sequence
    }

    fun slice(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        assert!(arg2 <= 0x1::vector::length<u8>(arg0), 1);
        let v0 = 0x1::vector::empty<u8>();
        while (arg1 < arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    public fun verify(arg0: &Vaa, arg1: &0x2::vec_map::VecMap<u8, vector<u8>>, arg2: u64) : bool {
        let v0 = 0x2::hash::keccak256(&arg0.body);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Signature>(&arg0.signatures)) {
            let v3 = 0x1::vector::borrow<Signature>(&arg0.signatures, v2);
            if (0x2::vec_map::contains<u8, vector<u8>>(arg1, &v3.guardian_index)) {
                let v4 = 0x2::ecdsa_k1::secp256k1_ecrecover(&v3.sig, &v0, 0);
                let v5 = 0x2::ecdsa_k1::decompress_pubkey(&v4);
                let v6 = eth_address(&v5);
                if (&v6 == 0x2::vec_map::get<u8, vector<u8>>(arg1, &v3.guardian_index)) {
                    v1 = v1 + 1;
                };
            };
            v2 = v2 + 1;
        };
        v1 >= arg2
    }

    // decompiled from Move bytecode v7
}

