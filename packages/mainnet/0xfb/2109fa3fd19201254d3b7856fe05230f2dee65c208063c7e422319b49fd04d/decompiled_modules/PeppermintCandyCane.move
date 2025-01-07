module 0xfb2109fa3fd19201254d3b7856fe05230f2dee65c208063c7e422319b49fd04d::PeppermintCandyCane {
    struct PEPPERMINTCANDYCANE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPPERMINTCANDYCANE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPPERMINTCANDYCANE>(arg0, 0, b"COS", b"Peppermint Candy Cane", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Hand_Item_Peppermint_Candy_Cane.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPPERMINTCANDYCANE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPPERMINTCANDYCANE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

