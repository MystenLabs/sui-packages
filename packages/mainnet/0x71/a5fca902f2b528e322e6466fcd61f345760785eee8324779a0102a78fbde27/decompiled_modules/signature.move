module 0xf78977221c9420f9a8ecf39b6bc28f7a576f92179bc29ecc34edca80ac7d9c55::signature {
    public fun verify_signature<T0>(arg0: &T0, arg1: vector<u8>, arg2: vector<u8>) {
        let v0 = 0x1::bcs::to_bytes<T0>(arg0);
        assert!(0x2::ed25519::ed25519_verify(&arg1, &arg2, &v0), 100);
    }

    // decompiled from Move bytecode v6
}

