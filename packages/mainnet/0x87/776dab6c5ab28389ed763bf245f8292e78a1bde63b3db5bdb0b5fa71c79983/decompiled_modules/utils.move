module 0x87776dab6c5ab28389ed763bf245f8292e78a1bde63b3db5bdb0b5fa71c79983::utils {
    public(friend) fun ecrecover(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 1)
    }

    // decompiled from Move bytecode v6
}

