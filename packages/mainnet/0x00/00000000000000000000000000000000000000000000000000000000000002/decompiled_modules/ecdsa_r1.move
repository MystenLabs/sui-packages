module 0x2::ecdsa_r1 {
    native public fun secp256r1_ecrecover(arg0: &vector<u8>, arg1: &vector<u8>, arg2: u8) : vector<u8>;
    native public fun secp256r1_verify(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u8) : bool;
    // decompiled from Move bytecode v6
}

