module 0xb668e6cdc1ed25686f8f2370464cccfd40b44944b1c0d6c6aa3ed93c3d2b2a70::sdoge {
    struct SDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOGE>(arg0, 6, b"SDOGE", b"SloppyDoge", b"Introducing SloppyDoge  - the newest, messiest meme token on the #Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/doge_8768549ac8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

