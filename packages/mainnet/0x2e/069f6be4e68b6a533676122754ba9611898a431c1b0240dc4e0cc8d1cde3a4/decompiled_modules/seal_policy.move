module 0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::seal_policy {
    public fun seal_approve<T0>(arg0: vector<u8>, arg1: &0x9aa904f2d8e55626f4ba4d3c76fd48fb84f00e86f2bfd558980b1d6268828b8b::enclave::Enclave<T0>, arg2: u64, arg3: vector<u8>, arg4: vector<u8>) {
        assert!(arg0 == x"00", 13906834290307563522);
        assert!(0x9aa904f2d8e55626f4ba4d3c76fd48fb84f00e86f2bfd558980b1d6268828b8b::enclave::verify_signature<T0, vector<u8>>(arg1, 1, arg2, arg3, &arg4), 13906834303192596484);
    }

    // decompiled from Move bytecode v7
}

