module 0x20672918f20c573f34a16eaf3444a18825849b2d48bec3f61e9725d73767ea4::birddog {
    struct BIRDDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRDDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRDDOG>(arg0, 6, b"BIRDDOG", b"BirdDog Club", b"Birddogs Boys Club is redefining the intersection of memes and culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_d70ccb0860_8074c75846.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRDDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIRDDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

