module 0x7ecdba7dde13dabe1ecf08c2670569bbfc135a812ea7fab81d24ea73bd942f3::utils {
    public(friend) fun ecrecover(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 1)
    }

    // decompiled from Move bytecode v6
}

