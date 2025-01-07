module 0x42261ae6d6dc35037d24f5b4ded2f6d26358f2caa7fa0b7a3b13c2fafbfac833::fade {
    struct FADE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FADE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FADE>(arg0, 6, b"FADE", b"Low Taper Fade", b"the meme is still massive", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_e7b71143c2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FADE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FADE>>(v1);
    }

    // decompiled from Move bytecode v6
}

