module 0xc08acf679e0c4e3c1328e3dc3b349e4b24428a12d3830471bd8b1f9e4201585e::utils {
    public(friend) fun ecrecover(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 1)
    }

    // decompiled from Move bytecode v6
}

