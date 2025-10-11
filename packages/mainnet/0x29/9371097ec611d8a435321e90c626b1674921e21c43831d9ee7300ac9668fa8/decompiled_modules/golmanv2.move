module 0x299371097ec611d8a435321e90c626b1674921e21c43831d9ee7300ac9668fa8::golmanv2 {
    struct GOLMANV2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLMANV2, arg1: &mut 0x2::tx_context::TxContext) {
        0x8c043c204c287be23ded2b80b85a3fdc798017b65bac20ece94fe24ec3b54c9e::connector_v3::new<GOLMANV2>(arg0, 871970541, b"golmanv2", b"GOLMANV2", b"golmanv2 launching by suifun", b"http://127.0.0.1:8000/api/v1/blob/JVygCKfqLDURz9L6VDwJbpmuWwTfJ9ZsWw5ktrLhdso", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

