module 0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::deploy_hook {
    public(friend) fun run(arg0: &mut 0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::schema::Schema, arg1: &mut 0x2::tx_context::TxContext) {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::set<u32>(0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::schema::counter(arg0), 0);
    }

    // decompiled from Move bytecode v6
}

