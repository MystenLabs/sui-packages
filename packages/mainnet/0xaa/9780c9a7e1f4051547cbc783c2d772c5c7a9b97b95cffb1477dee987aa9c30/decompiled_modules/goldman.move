module 0xaa9780c9a7e1f4051547cbc783c2d772c5c7a9b97b95cffb1477dee987aa9c30::goldman {
    struct GOLDMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDMAN, arg1: &mut 0x2::tx_context::TxContext) {
        0x8c043c204c287be23ded2b80b85a3fdc798017b65bac20ece94fe24ec3b54c9e::connector_v3::new<GOLDMAN>(arg0, 607863178, b"goldman", b"GOLDMAN", b"goldman luanch by suifun", b"http://127.0.0.1:8000/api/v1/blob/JVygCKfqLDURz9L6VDwJbpmuWwTfJ9ZsWw5ktrLhdso", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

