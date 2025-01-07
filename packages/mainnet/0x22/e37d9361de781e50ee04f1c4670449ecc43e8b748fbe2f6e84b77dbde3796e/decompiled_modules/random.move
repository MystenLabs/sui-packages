module 0x22e37d9361de781e50ee04f1c4670449ecc43e8b748fbe2f6e84b77dbde3796e::random {
    public fun generate_number(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        0x22e37d9361de781e50ee04f1c4670449ecc43e8b748fbe2f6e84b77dbde3796e::vector_utils::from_be_bytes(generate_pseudorandom(arg1)) % arg0
    }

    public fun generate_pseudorandom(arg0: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x2::tx_context::fresh_object_address(arg0);
        0x1::bcs::to_bytes<address>(&v0)
    }

    // decompiled from Move bytecode v6
}

