module 0xd8e1ecd9f3fd024c1a29db4d14fe24faa18463a928287ec0d3796cace61edbcf::grow_sui {
    struct GROW_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROW_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        0xd8e1ecd9f3fd024c1a29db4d14fe24faa18463a928287ec0d3796cace61edbcf::constructor::create_coin<GROW_SUI>(arg0, b"GSUI", b"Grow SUI", b"https://example.com/usd.png", arg1);
    }

    // decompiled from Move bytecode v6
}

