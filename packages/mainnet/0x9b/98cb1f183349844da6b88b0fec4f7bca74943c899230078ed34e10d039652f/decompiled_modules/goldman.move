module 0x9b98cb1f183349844da6b88b0fec4f7bca74943c899230078ed34e10d039652f::goldman {
    struct GOLDMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDMAN, arg1: &mut 0x2::tx_context::TxContext) {
        0xc128bbcd3ebc450822c2f64f2defb727bccb9e255277b04979b41a8f4ae0318::connector_v3::new<GOLDMAN>(arg0, 1000, b"goldman", b"GOLDMAN", b"goldman by suifun", b"http://127.0.0.1:8000/api/v1/blob/uiZ7nQO4FFHUvTUuYBp4pEPONjh4K57RYLm2u4yaQhg", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

