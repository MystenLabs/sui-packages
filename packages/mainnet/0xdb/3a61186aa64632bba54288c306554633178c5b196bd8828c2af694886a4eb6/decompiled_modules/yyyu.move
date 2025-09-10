module 0xdb3a61186aa64632bba54288c306554633178c5b196bd8828c2af694886a4eb6::yyyu {
    struct YYYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: YYYU, arg1: &mut 0x2::tx_context::TxContext) {
        0xc907e599b1690d7b75b3d15acb57f48f762141ca86828abd435b98588a1f8414::connector_v3::new<YYYU>(arg0, 811186147, b"yuu", b"YYYU", b"yuu by suifun", b"http://127.0.0.1:8000/api/v1/blob/pOEoFcl9du8bnRjSfxUhkWNGzVtjAnGD98aBUtDhnVs", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

