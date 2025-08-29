module 0x7f17a4b681e87fd8fc4c92d507808529b247d39b39c85418393223f8d8730894::hio {
    struct HIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIO, arg1: &mut 0x2::tx_context::TxContext) {
        0x14ad675b1cac174d3c7176588b670c6a9e70e1bc2d8497339d8f1302024582b8::connector_v3::new<HIO>(arg0, 712406326, b"hio", b"HIO", b"hio by suifun", b"http://127.0.0.1:8000/api/v1/blob/bHmegIX2U2YDbchoV3KOIfxqCGuAAy-SV1P2QxIZK0E", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

