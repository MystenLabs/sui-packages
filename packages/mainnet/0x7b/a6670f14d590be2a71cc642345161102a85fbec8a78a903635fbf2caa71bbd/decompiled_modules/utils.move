module 0x7ba6670f14d590be2a71cc642345161102a85fbec8a78a903635fbf2caa71bbd::utils {
    public(friend) fun ecrecover(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 1)
    }

    public(friend) fun keccak_message(arg0: vector<u8>) : vector<u8> {
        0x2::hash::keccak256(&arg0)
    }

    // decompiled from Move bytecode v6
}

