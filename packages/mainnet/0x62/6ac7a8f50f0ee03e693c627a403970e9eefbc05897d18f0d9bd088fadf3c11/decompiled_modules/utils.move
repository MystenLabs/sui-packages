module 0x626ac7a8f50f0ee03e693c627a403970e9eefbc05897d18f0d9bd088fadf3c11::utils {
    public(friend) fun ecrecover(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 1)
    }

    // decompiled from Move bytecode v6
}

