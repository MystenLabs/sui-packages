module 0xa4654d465ccfad2f1dee3231f4b6797fc22a5489299186417bfbc589dc2b3241::utils {
    public(friend) fun ecrecover(arg0: vector<u8>, arg1: vector<u8>) : address {
        0x2::address::from_bytes(0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 0))
    }

    public(friend) fun keccak_message(arg0: vector<u8>) : vector<u8> {
        0x2::hash::keccak256(&arg0)
    }

    // decompiled from Move bytecode v6
}

