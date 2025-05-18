module 0xc987d60f074c8265cc646f798acb2bcad9a103ccac39f6c4c458edf09481eff3::utils {
    public(friend) fun ecrecover(arg0: vector<u8>, arg1: vector<u8>) : address {
        0x2::address::from_bytes(0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 0))
    }

    public(friend) fun keccak_message(arg0: vector<u8>) : vector<u8> {
        0x2::hash::keccak256(&arg0)
    }

    // decompiled from Move bytecode v6
}

