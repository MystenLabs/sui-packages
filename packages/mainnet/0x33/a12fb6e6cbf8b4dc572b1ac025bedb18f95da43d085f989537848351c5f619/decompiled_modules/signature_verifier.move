module 0x33a12fb6e6cbf8b4dc572b1ac025bedb18f95da43d085f989537848351c5f619::signature_verifier {
    struct PubKey has key {
        id: 0x2::object::UID,
        value: vector<u8>,
    }

    struct VerifierAdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PubKey{
            id    : 0x2::object::new(arg0),
            value : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::share_object<PubKey>(v0);
        let v1 = VerifierAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<VerifierAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun init_pub_key(arg0: &VerifierAdminCap, arg1: &mut PubKey, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.value = arg2;
    }

    public fun verify_signature(arg0: &PubKey, arg1: u128, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: vector<u8>) : bool {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x33a12fb6e6cbf8b4dc572b1ac025bedb18f95da43d085f989537848351c5f619::generic_converter::u128_to_vec8(arg1));
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, arg3);
        0x1::vector::append<u8>(&mut v0, arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg5));
        let v1 = 0x1::hash::sha2_256(v0);
        0x2::ed25519::ed25519_verify(&arg6, &arg0.value, &v1)
    }

    // decompiled from Move bytecode v6
}

