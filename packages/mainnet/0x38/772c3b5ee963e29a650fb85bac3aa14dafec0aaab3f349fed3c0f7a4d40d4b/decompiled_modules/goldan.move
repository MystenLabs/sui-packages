module 0x38772c3b5ee963e29a650fb85bac3aa14dafec0aaab3f349fed3c0f7a4d40d4b::goldan {
    struct GOLDAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDAN, arg1: &mut 0x2::tx_context::TxContext) {
        0xcc2240a338a87725aaef79a4dda232876bd517aff8e760cdb5c3152932fb8852::connector_v3::new<GOLDAN>(arg0, 34395563, b"goldman", b"GOLDAN", b"goldman meme launch by suifun", b"http://127.0.0.1:8000/api/v1/blob/JVygCKfqLDURz9L6VDwJbpmuWwTfJ9ZsWw5ktrLhdso", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

