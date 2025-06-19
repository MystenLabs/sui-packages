module 0xd81a67266de3fa0f4e3e1a2f1029b23bef2fb24cf458b461fd20a90d1b34c4d9::utils {
    public(friend) fun ecrecover(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 1)
    }

    // decompiled from Move bytecode v6
}

