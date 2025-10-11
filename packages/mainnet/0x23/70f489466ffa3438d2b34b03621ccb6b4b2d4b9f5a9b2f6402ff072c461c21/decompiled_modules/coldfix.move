module 0x2370f489466ffa3438d2b34b03621ccb6b4b2d4b9f5a9b2f6402ff072c461c21::coldfix {
    struct COLDFIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: COLDFIX, arg1: &mut 0x2::tx_context::TxContext) {
        0xef585bb020c325b52f49e6bf5f8c4ea336a5028a44a6e51b5c43b62ff2c7a7f7::connector_v3::new<COLDFIX>(arg0, 372222553, b"coldfix", b"COLDFIX", b"coldfix by suifun", b"http://127.0.0.1:8000/api/v1/blob/JVygCKfqLDURz9L6VDwJbpmuWwTfJ9ZsWw5ktrLhdso", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

