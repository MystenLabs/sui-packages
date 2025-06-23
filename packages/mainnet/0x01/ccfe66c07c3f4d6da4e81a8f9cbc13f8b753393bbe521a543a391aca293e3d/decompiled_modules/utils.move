module 0x1ccfe66c07c3f4d6da4e81a8f9cbc13f8b753393bbe521a543a391aca293e3d::utils {
    public(friend) fun ecrecover(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 1)
    }

    // decompiled from Move bytecode v6
}

