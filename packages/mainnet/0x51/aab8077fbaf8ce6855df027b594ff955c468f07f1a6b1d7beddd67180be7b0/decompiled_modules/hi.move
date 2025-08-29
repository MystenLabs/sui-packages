module 0x51aab8077fbaf8ce6855df027b594ff955c468f07f1a6b1d7beddd67180be7b0::hi {
    struct HI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HI, arg1: &mut 0x2::tx_context::TxContext) {
        0x14ad675b1cac174d3c7176588b670c6a9e70e1bc2d8497339d8f1302024582b8::connector_v3::new<HI>(arg0, 353418964, b"hi", b"HI", b"hi by suifun", b"http://127.0.0.1:8000/api/v1/blob/a5TrqC2HdeJ5rgCqQ5aWGS8uTkgLShPGDXGaLRzWudU", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

