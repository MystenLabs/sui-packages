module 0xbb24680526bd0d6d36e83f77904e6b233a111fa13dbebadfe5e9e44fbd66fb51::utils {
    public(friend) fun ecrecover(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 1)
    }

    // decompiled from Move bytecode v6
}

