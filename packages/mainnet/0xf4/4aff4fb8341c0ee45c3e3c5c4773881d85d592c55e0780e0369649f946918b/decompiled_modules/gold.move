module 0xf44aff4fb8341c0ee45c3e3c5c4773881d85d592c55e0780e0369649f946918b::gold {
    struct GOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLD, arg1: &mut 0x2::tx_context::TxContext) {
        0xbc5950046e56037c8a5020dda371b81ee421490469d0bdda575ff80d6e284a8e::connector_v3::new<GOLD>(arg0, 1000, b"GOLD", b"GOLD", x"676f6c6420636f696e2062792073756966756e20f09f9887", b"http://localhost:3001/move-generator/image/bHmegIX2U2YDbchoV3KOIfxqCGuAAy-SV1P2QxIZK0E", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

