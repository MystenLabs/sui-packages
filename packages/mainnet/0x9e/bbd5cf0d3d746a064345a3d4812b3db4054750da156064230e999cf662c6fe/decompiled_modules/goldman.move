module 0x9ebbd5cf0d3d746a064345a3d4812b3db4054750da156064230e999cf662c6fe::goldman {
    struct GOLDMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDMAN, arg1: &mut 0x2::tx_context::TxContext) {
        0xb237dca14b895ec0f743b175a7e4747ec25b567c65df1f0b38a7da105be92a36::connector_v3::new<GOLDMAN>(arg0, 1000, b"goldman", b"GOLDMAN", b"goldman by suifun", b"http://127.0.0.1:8000/api/v1/blob/uiZ7nQO4FFHUvTUuYBp4pEPONjh4K57RYLm2u4yaQhg", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

