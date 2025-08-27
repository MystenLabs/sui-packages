module 0x7b4e36c6632901028dd65877fd235333bf7653beff73474b1962882f1ceed81a::payload {
    struct Payload has drop {
        data: vector<u8>,
        signature: vector<u8>,
    }

    public fun decode(arg0: &vector<u8>) : Payload {
        let v0 = 0x5a6ab91581604273c78ef5bf421f0f57868ac40e519d39e2b80f39e9ddaef12e::decoder::decode_list(arg0);
        Payload{
            data      : *0x1::vector::borrow<vector<u8>>(&v0, 0),
            signature : *0x1::vector::borrow<vector<u8>>(&v0, 1),
        }
    }

    fun extract_pubkey(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::pop_back<u8>(&mut arg1);
        let v1 = v0;
        let v2 = 27;
        if (v0 >= v2) {
            v1 = v0 - v2;
        };
        0x1::vector::push_back<u8>(&mut arg1, v1);
        let v3 = 0x2::ecdsa_k1::secp256k1_ecrecover(&arg1, &arg0, 0);
        full_pubkey_to_eth_address(0x2::ecdsa_k1::decompress_pubkey(&v3))
    }

    public fun full_pubkey_to_eth_address(arg0: vector<u8>) : vector<u8> {
        if (0x1::vector::length<u8>(&arg0) == 65 && *0x1::vector::borrow<u8>(&arg0, 0) == 4) {
            let v0 = 0x1::vector::empty<u8>();
            let v1 = 1;
            while (v1 < 65) {
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0, v1));
                v1 = v1 + 1;
            };
            return pubkey_to_eth_address(v0)
        };
        pubkey_to_eth_address(arg0)
    }

    public fun get_message(arg0: &Payload) : 0x7b4e36c6632901028dd65877fd235333bf7653beff73474b1962882f1ceed81a::message::Message {
        0x7b4e36c6632901028dd65877fd235333bf7653beff73474b1962882f1ceed81a::message::decode(&arg0.data)
    }

    public fun new(arg0: vector<u8>, arg1: vector<u8>) : Payload {
        Payload{
            data      : arg0,
            signature : arg1,
        }
    }

    public fun pubkey_to_eth_address(arg0: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) == 64, 1);
        let v0 = 0x2::hash::keccak256(&arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 12;
        while (v2 < 32) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun recover_signer(arg0: &Payload) : vector<u8> {
        extract_pubkey(arg0.data, arg0.signature)
    }

    // decompiled from Move bytecode v6
}

