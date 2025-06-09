module 0xe1be1ba8d111a991d87493697340a393151190a3ad12133cea8fac9dbea0f228::utils {
    public(friend) fun ecrecover(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 1)
    }

    public(friend) fun verify(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : bool {
        0x2::ecdsa_k1::secp256k1_verify(&arg0, &arg2, &arg1, 1)
    }

    // decompiled from Move bytecode v6
}

