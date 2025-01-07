module 0xa6cf3286ad01d066be40f11bfe891b86060ef89dd12994687f64a9c852ef72af::pixels {
    struct PIXELS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXELS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIXELS>(arg0, 6, b"PIXELS", b"pixelartfighter", b" Love Skateboard  Hate Scammer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/modeng_eba79902af.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXELS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIXELS>>(v1);
    }

    // decompiled from Move bytecode v6
}

