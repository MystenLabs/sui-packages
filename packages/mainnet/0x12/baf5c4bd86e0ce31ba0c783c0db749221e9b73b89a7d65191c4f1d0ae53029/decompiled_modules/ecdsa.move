module 0x12baf5c4bd86e0ce31ba0c783c0db749221e9b73b89a7d65191c4f1d0ae53029::ecdsa {
    struct VerifiedEvent has copy, drop {
        is_verified: bool,
    }

    struct Output has store, key {
        id: 0x2::object::UID,
        value: vector<u8>,
    }

    public entry fun secp256k1_verify(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) {
        let v0 = VerifiedEvent{is_verified: 0x2::ecdsa_k1::secp256k1_verify(&arg0, &arg1, &arg2, 0)};
        0x2::event::emit<VerifiedEvent>(v0);
    }

    public entry fun keccak256(arg0: vector<u8>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Output{
            id    : 0x2::object::new(arg2),
            value : 0x2::hash::keccak256(&arg0),
        };
        0x2::transfer::public_transfer<Output>(v0, arg1);
    }

    public entry fun ecrecover(arg0: vector<u8>, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Output{
            id    : 0x2::object::new(arg3),
            value : 0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 0),
        };
        0x2::transfer::public_transfer<Output>(v0, arg2);
    }

    public entry fun ecrecover_to_eth_address(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::borrow_mut<u8>(&mut arg0, 64);
        if (*v0 == 27) {
            *v0 = 0;
        } else if (*v0 == 28) {
            *v0 = 1;
        } else if (*v0 > 35) {
            *v0 = (*v0 - 1) % 2;
        };
        let v1 = 0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 0);
        let v2 = 0x2::ecdsa_k1::decompress_pubkey(&v1);
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 1;
        while (v4 < 65) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&v2, v4));
            v4 = v4 + 1;
        };
        let v5 = 0x2::hash::keccak256(&v3);
        let v6 = 0x1::vector::empty<u8>();
        let v7 = 12;
        while (v7 < 32) {
            0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&v5, v7));
            v7 = v7 + 1;
        };
        v6
    }

    // decompiled from Move bytecode v6
}

