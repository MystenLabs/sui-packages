module 0x5be749b289a958ae6020271d6c8b3835fd991eb0a9b83220e2f588bce7ae3b33::dogecast {
    struct DOGECAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGECAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGECAST>(arg0, 6, b"DOGECAST", b"DOGECAST ON SUI", b"A meme coin inspired by Elons and Viveks up and coming podcast...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5055_590b976734.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGECAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGECAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

