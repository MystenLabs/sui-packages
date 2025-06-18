module 0xb664e5f1e85cec77d0da9097e18fa602cfefa7a0e16f28d7396e806dc90e74f0::utils {
    public(friend) fun ecrecover(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 1)
    }

    // decompiled from Move bytecode v6
}

