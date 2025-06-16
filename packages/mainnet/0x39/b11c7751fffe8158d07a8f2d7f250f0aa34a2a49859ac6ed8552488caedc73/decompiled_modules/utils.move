module 0x39b11c7751fffe8158d07a8f2d7f250f0aa34a2a49859ac6ed8552488caedc73::utils {
    public(friend) fun ecrecover(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 1)
    }

    // decompiled from Move bytecode v6
}

