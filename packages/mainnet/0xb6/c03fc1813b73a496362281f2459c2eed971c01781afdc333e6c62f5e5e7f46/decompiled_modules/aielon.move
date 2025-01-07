module 0xb6c03fc1813b73a496362281f2459c2eed971c01781afdc333e6c62f5e5e7f46::aielon {
    struct AIELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIELON>(arg0, 6, b"AIELON", b"AIELONMUSK", b"AI Trend For Elon Musk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1661_8bdd986588.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

