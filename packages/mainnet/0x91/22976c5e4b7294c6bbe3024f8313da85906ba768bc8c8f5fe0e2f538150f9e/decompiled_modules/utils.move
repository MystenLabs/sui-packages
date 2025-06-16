module 0x9122976c5e4b7294c6bbe3024f8313da85906ba768bc8c8f5fe0e2f538150f9e::utils {
    public(friend) fun ecrecover(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 1)
    }

    // decompiled from Move bytecode v6
}

