module 0x98bed2a42b041eaa6b46aee3a0953edf12eaef2497a15d26077bfbb483f2711c::signature {
    public fun verify_signature<T0>(arg0: &T0, arg1: vector<u8>, arg2: vector<u8>) {
        let v0 = 0x1::bcs::to_bytes<T0>(arg0);
        assert!(0x2::ed25519::ed25519_verify(&arg1, &arg2, &v0), 100);
    }

    // decompiled from Move bytecode v6
}

