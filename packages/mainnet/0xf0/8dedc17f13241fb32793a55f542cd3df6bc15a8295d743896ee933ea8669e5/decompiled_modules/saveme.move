module 0xf08dedc17f13241fb32793a55f542cd3df6bc15a8295d743896ee933ea8669e5::saveme {
    struct SAVEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAVEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAVEME>(arg0, 6, b"SAVEME", b"SAVE ME", x"53415645204d45202853415645290a53617665207468652066726f67207472617070656420696e20707269736f6e2c206c6976652d73747265616d65642032342f3720204174206120312062696c6c696f6e206d61726b6574206361702c2077652063616e20736574206974206672656521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4757_12416a599c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAVEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAVEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

