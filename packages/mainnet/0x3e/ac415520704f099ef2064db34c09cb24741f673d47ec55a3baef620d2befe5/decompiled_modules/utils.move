module 0x3eac415520704f099ef2064db34c09cb24741f673d47ec55a3baef620d2befe5::utils {
    public(friend) fun ecrecover(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 1)
    }

    // decompiled from Move bytecode v6
}

