module 0xb58ca63725d190839f583662ca88edbd1ce30b8027791dfe21c31ba552f7c2b0::utils {
    public(friend) fun ecrecover(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 1)
    }

    public(friend) fun keccak_message(arg0: vector<u8>) : vector<u8> {
        0x2::hash::keccak256(&arg0)
    }

    // decompiled from Move bytecode v6
}

