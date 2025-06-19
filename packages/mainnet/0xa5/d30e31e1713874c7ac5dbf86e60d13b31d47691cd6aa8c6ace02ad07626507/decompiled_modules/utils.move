module 0xa5d30e31e1713874c7ac5dbf86e60d13b31d47691cd6aa8c6ace02ad07626507::utils {
    public(friend) fun ecrecover(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 1)
    }

    // decompiled from Move bytecode v6
}

