module 0xdecf901713d3e939ac2d08aa57d11c238ccf92bc4001f93515b0e225a7efc6cd::goldman_sui {
    struct GOLDMAN_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDMAN_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x8c043c204c287be23ded2b80b85a3fdc798017b65bac20ece94fe24ec3b54c9e::connector_v3::new<GOLDMAN_SUI>(arg0, 150146442, b"goldman_sui", b"GOLDMAN_SUI", b"goldman_sui luanch by suifun", b"http://127.0.0.1:8000/api/v1/blob/JVygCKfqLDURz9L6VDwJbpmuWwTfJ9ZsWw5ktrLhdso", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

