module 0xd62fb1f32eb928c0f174876698280dae37d4b5f971f08917f3e54a8c7e2b960f::signature {
    public(friend) fun verify_signature<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &T0) {
        let v0 = 0x2::bcs::to_bytes<T0>(arg2);
        assert!(0x2::ed25519::ed25519_verify(&arg0, &arg1, &v0), 1);
    }

    // decompiled from Move bytecode v6
}

