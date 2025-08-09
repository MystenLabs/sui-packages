module 0xa53bd93d074af580dab1577c9a6983bf67f513a673694743e37b57c94efe1316::gold {
    struct GOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLD, arg1: &mut 0x2::tx_context::TxContext) {
        0xbc5950046e56037c8a5020dda371b81ee421490469d0bdda575ff80d6e284a8e::connector_v3::new<GOLD>(arg0, 1000, b"GOLD", b"GOLD", x"676f6c6420636f696e2062792073756966756e20f09f9887", b"http://localhost:3001/move-generator/image/bHmegIX2U2YDbchoV3KOIfxqCGuAAy-SV1P2QxIZK0E", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

