module 0xaf1516df4a02d087787faca64014fb9701ee2d1f228ad73e8d1534cc2a1c4fc5::SnowyWhiteAntlers {
    struct SNOWYWHITEANTLERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOWYWHITEANTLERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOWYWHITEANTLERS>(arg0, 0, b"COS", b"Snowy White Antlers", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Snowy_White_Antlers.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNOWYWHITEANTLERS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOWYWHITEANTLERS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

