module 0xc4483eb90a66694318db781b7dd47d781a7c8fcf2a7ffca79379fd12569008e9::goldman {
    struct GOLDMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDMAN, arg1: &mut 0x2::tx_context::TxContext) {
        0xb237dca14b895ec0f743b175a7e4747ec25b567c65df1f0b38a7da105be92a36::connector_v3::new<GOLDMAN>(arg0, 1000, b"goldman", b"GOLDMAN", b"goldman by suifun", b"http://127.0.0.1:8000/api/v1/blob/uiZ7nQO4FFHUvTUuYBp4pEPONjh4K57RYLm2u4yaQhg", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

