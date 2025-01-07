module 0x50a20b1a64623af756b8f15d711c8d596b7f7b6a7fd30630bee8d7afcde8b018::signature {
    public fun verify_signature<T0>(arg0: &T0, arg1: vector<u8>, arg2: vector<u8>) {
        let v0 = 0x1::bcs::to_bytes<T0>(arg0);
        assert!(0x2::ed25519::ed25519_verify(&arg1, &arg2, &v0), 100);
    }

    // decompiled from Move bytecode v6
}

