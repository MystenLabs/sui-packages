module 0x68321f4b0754f3089604ea90dae48c1a9900a601d18ea8eae5fcc046d147593e::signature {
    public(friend) fun verify_signature<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &T0) {
        let v0 = 0x2::bcs::to_bytes<T0>(arg2);
        assert!(0x2::ed25519::ed25519_verify(&arg0, &arg1, &v0), 1);
    }

    // decompiled from Move bytecode v6
}

