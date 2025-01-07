module 0x4012f662475c33e0a39de39ee2b2e02385727465245fc8290c4edd57710c05d3::MICKFEARSON {
    struct MICKFEARSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MICKFEARSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MICKFEARSON>(arg0, 0, b"COS", b"MICK FEAR SON", b"Limited-edition Aurahma swag from the Exclusive Battle Prototype event held in May 2023-the first playtesting experience for our Founding StarGarden holders-for those who stand in support with the one who fears RACCOON.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/MICK_FEAR_SON.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MICKFEARSON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MICKFEARSON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

