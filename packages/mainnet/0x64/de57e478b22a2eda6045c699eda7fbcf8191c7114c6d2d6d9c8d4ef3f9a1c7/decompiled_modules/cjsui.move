module 0x64de57e478b22a2eda6045c699eda7fbcf8191c7114c6d2d6d9c8d4ef3f9a1c7::cjsui {
    struct CJSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CJSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CJSUI>(arg0, 6, b"CJSUI", b"Carl Johnson on SUI CTO", b"Carl Johnson on SUI. CTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/carllogo_0b49e35b04.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CJSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CJSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

