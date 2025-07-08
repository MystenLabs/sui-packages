module 0x2::vdf {
    public fun hash_to_input(arg0: &vector<u8>) : vector<u8> {
        hash_to_input_internal(arg0)
    }

    native fun hash_to_input_internal(arg0: &vector<u8>) : vector<u8>;
    public fun vdf_verify(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u64) : bool {
        vdf_verify_internal(arg0, arg1, arg2, arg3)
    }

    native fun vdf_verify_internal(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u64) : bool;
    // decompiled from Move bytecode v6
}

