module 0xd139c1ae0ca8f3cd96d25d17fc839ecd4f72dcb6fc925728a14b31b4bf08fa03::hog {
    struct HOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOG>(arg0, 6, b"HOG", b"HOG SUI", b"Hedgehog meme on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_02_1_1024x937_b8930ff70e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

