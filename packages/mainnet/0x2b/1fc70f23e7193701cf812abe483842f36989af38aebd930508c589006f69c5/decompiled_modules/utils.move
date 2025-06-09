module 0x2b1fc70f23e7193701cf812abe483842f36989af38aebd930508c589006f69c5::utils {
    public(friend) fun ecrecover(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 1)
    }

    public(friend) fun verify(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : bool {
        0x2::ecdsa_k1::secp256k1_verify(&arg0, &arg2, &arg1, 1)
    }

    // decompiled from Move bytecode v6
}

