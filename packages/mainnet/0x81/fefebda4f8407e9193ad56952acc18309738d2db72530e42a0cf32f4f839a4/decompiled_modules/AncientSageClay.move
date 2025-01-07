module 0x81fefebda4f8407e9193ad56952acc18309738d2db72530e42a0cf32f4f839a4::AncientSageClay {
    struct ANCIENTSAGECLAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANCIENTSAGECLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANCIENTSAGECLAY>(arg0, 0, b"COS", b"Ancient Sage-Clay", b"Little one, what have you gotten into?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Body_Ancient_Sage-Clay.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANCIENTSAGECLAY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANCIENTSAGECLAY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

