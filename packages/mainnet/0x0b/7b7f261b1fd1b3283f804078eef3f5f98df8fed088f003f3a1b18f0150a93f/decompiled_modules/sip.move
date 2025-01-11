module 0xb7b7f261b1fd1b3283f804078eef3f5f98df8fed088f003f3a1b18f0150a93f::sip {
    struct SIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SIP>(arg0, 6, b"SIP", b"Suiperb by SuiAI", x"5475726e696e67204c617567687320696e746f2050726f6669747320f09f9882203df09f92b02e4120446563656e7472616c697a6564204d656d652045636f6e6f6d79204149206f6e2053554920f09f92a7f09f90b8f09f9191", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Nevtelen_d2fc846bae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SIP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

