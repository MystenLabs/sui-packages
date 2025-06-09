module 0xc81be371f8eeb83c207a61b2c2485a3afbee9d7695c38e0794ea77454bbd5044::utils {
    public(friend) fun ecrecover(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 0)
    }

    // decompiled from Move bytecode v6
}

