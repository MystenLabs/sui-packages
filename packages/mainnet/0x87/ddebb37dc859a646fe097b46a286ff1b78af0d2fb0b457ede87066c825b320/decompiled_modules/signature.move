module 0x87ddebb37dc859a646fe097b46a286ff1b78af0d2fb0b457ede87066c825b320::signature {
    public(friend) fun verify_signature<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &T0) {
        let v0 = 0x2::bcs::to_bytes<T0>(arg2);
        assert!(0x2::ed25519::ed25519_verify(&arg0, &arg1, &v0), 1);
    }

    // decompiled from Move bytecode v6
}

