module 0x523c3eb50dc5969d41ec325fc61a0e58cb4a559ee5eb6d30b6b2d254febf419d::honk {
    struct HONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HONK>(arg0, 6, b"Honk", b"HONKonSUI", b"The Honk Bonk rivarly is one of the most epic rivalries in internet meme culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241013_003027_3c22c4c7df.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

