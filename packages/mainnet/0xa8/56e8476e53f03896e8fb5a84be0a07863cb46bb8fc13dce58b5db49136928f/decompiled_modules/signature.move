module 0xa856e8476e53f03896e8fb5a84be0a07863cb46bb8fc13dce58b5db49136928f::signature {
    public fun get_message(arg0: address, arg1: u64) : vector<u8> {
        let v0 = 0x2::address::to_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        v0
    }

    public fun verify_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : bool {
        0x2::ed25519::ed25519_verify(&arg0, &arg1, &arg2)
    }

    // decompiled from Move bytecode v6
}

