module 0x2b4a813da194941fc1bdff1272aff1849ba504a1de55f9b289a1174b3543c9e3::signature {
    public(friend) fun verify_signature<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &T0) {
        let v0 = 0x2::bcs::to_bytes<T0>(arg2);
        assert!(0x2::ed25519::ed25519_verify(&arg0, &arg1, &v0), 1);
    }

    // decompiled from Move bytecode v6
}

