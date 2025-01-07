module 0x59168e3225da30515476d29d35ed4857dac2b62f57ff4a93e152c995811a8ebc::smormu {
    struct SMORMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMORMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMORMU>(arg0, 6, b"SMORMU", b"SMORMU  SHRIMP", b"Meet $SMORMU, the newest star in the meme token galaxy! Smormu is a character from Smiling Friends. $SMORMU became a legendary meme on Reddit and X.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_1_6f13daa48e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMORMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMORMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

