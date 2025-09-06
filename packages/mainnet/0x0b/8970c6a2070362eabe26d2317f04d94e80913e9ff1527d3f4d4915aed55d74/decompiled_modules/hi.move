module 0xb8970c6a2070362eabe26d2317f04d94e80913e9ff1527d3f4d4915aed55d74::hi {
    struct HI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5168f47f1dfcc2cfbd94876454c90ace20490b5f272b61e753f1e739d252c789::connector_v3::new<HI>(arg0, 9030278, b"hi", b"HI", b"hi by suifun", b"http://127.0.0.1:8000/api/v1/blob/bHmegIX2U2YDbchoV3KOIfxqCGuAAy-SV1P2QxIZK0E", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

