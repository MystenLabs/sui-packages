module 0xe0cc02580485a2ebb7b1dba20d15aa0a605c0a6468ba3b56ec9a82b1d0d9123d::signature {
    public fun verify_signature<T0>(arg0: &T0, arg1: vector<u8>, arg2: vector<u8>) {
        let v0 = 0x1::bcs::to_bytes<T0>(arg0);
        assert!(0x2::ed25519::ed25519_verify(&arg1, &arg2, &v0), 100);
    }

    // decompiled from Move bytecode v6
}

