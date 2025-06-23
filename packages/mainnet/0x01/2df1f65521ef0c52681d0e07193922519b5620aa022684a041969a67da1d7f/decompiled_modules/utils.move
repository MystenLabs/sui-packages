module 0x12df1f65521ef0c52681d0e07193922519b5620aa022684a041969a67da1d7f::utils {
    public(friend) fun ecrecover(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 1)
    }

    // decompiled from Move bytecode v6
}

