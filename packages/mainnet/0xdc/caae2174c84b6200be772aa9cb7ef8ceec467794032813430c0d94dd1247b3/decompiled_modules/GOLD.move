module 0xdccaae2174c84b6200be772aa9cb7ef8ceec467794032813430c0d94dd1247b3::GOLD {
    struct GOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLD, arg1: &mut 0x2::tx_context::TxContext) {
        0xbc5950046e56037c8a5020dda371b81ee421490469d0bdda575ff80d6e284a8e::connector_v3::new<GOLD>(arg0, 1000, b"gold", b"GOLD", x"676f6c642062792073756966756e20f09f9887", b"http://127.0.0.1:8000/api/v1/blob/: 3W7mfOZERieooFYxx7Ae1ue7nB9qurw6Qx_cH-stPMY", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

