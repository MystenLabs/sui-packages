module 0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::payload_decoder {
    public fun decode_fee_payload(arg0: vector<u8>) : (u32, u256, u256) {
        abort 9999
    }

    public fun decode_mint_payload(arg0: vector<u8>) : (u32, u256, address, u256, u256, u256) {
        abort 9999
    }

    public fun decode_signatures(arg0: vector<u8>) : vector<vector<u8>> {
        abort 9999
    }

    public fun decode_valset(arg0: vector<u8>) : (u32, u256, vector<vector<u8>>, vector<u256>, u256) {
        abort 9999
    }

    // decompiled from Move bytecode v6
}

