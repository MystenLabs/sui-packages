module 0x1c5a151cc278249d125a6b037ea046c3f66868ee978284107852dae4988fc54e::goldcoin {
    struct GOLDCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x14ad675b1cac174d3c7176588b670c6a9e70e1bc2d8497339d8f1302024582b8::connector_v3::new<GOLDCOIN>(arg0, 1000, b"goldcoin", b"GOLDCOIN", b"goldcoin by suifun", b"http://127.0.0.1:8000/api/v1/blob/bHmegIX2U2YDbchoV3KOIfxqCGuAAy-SV1P2QxIZK0E", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

