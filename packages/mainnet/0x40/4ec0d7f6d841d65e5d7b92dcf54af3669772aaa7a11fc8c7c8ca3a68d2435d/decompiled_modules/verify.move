module 0x404ec0d7f6d841d65e5d7b92dcf54af3669772aaa7a11fc8c7c8ca3a68d2435d::verify {
    struct VerifiedEvent has copy, drop {
        is_verified: bool,
    }

    struct MyEvent has copy, drop {
        value: vector<u8>,
    }

    struct Output has store, key {
        id: 0x2::object::UID,
        value: bool,
    }

    public fun erecover_to_eth_address_and_reply(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
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

    fun pack_u256(arg0: u256) : vector<u8> {
        let v0 = 0x1::bcs::to_bytes<u256>(&arg0);
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public entry fun verify_sig(arg0: vector<u8>, arg1: vector<u8>, arg2: u256, arg3: u256, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, pack_u256(arg3));
        0x1::vector::append<u8>(&mut v0, pack_u256(arg2));
        let v1 = x"19457468657265756d205369676e6564204d6573736167653a0a3332";
        0x1::vector::append<u8>(&mut v1, 0x2::hash::keccak256(&v0));
        let v2 = Output{
            id    : 0x2::object::new(arg5),
            value : erecover_to_eth_address_and_reply(arg4, v1) == arg0,
        };
        0x2::transfer::public_transfer<Output>(v2, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

