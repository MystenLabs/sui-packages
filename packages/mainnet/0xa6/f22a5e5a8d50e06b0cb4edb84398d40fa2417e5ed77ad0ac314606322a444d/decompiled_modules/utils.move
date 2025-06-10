module 0xa6f22a5e5a8d50e06b0cb4edb84398d40fa2417e5ed77ad0ac314606322a444d::utils {
    public(friend) fun ecrecover(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 1)
    }

    public(friend) fun keccak_message(arg0: vector<u8>) : vector<u8> {
        0x2::hash::keccak256(&arg0)
    }

    // decompiled from Move bytecode v6
}

