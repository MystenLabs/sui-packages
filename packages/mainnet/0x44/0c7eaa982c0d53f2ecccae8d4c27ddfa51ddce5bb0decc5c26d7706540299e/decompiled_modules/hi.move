module 0x440c7eaa982c0d53f2ecccae8d4c27ddfa51ddce5bb0decc5c26d7706540299e::hi {
    struct HI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HI, arg1: &mut 0x2::tx_context::TxContext) {
        0x14ad675b1cac174d3c7176588b670c6a9e70e1bc2d8497339d8f1302024582b8::connector_v3::new<HI>(arg0, 125212188, b"hi", b"HI", b"hi by suifun", b"http://127.0.0.1:8000/api/v1/blob/bHmegIX2U2YDbchoV3KOIfxqCGuAAy-SV1P2QxIZK0E", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

