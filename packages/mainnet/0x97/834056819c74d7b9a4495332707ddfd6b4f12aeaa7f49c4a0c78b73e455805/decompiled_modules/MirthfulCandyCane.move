module 0x97834056819c74d7b9a4495332707ddfd6b4f12aeaa7f49c4a0c78b73e455805::MirthfulCandyCane {
    struct MIRTHFULCANDYCANE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIRTHFULCANDYCANE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIRTHFULCANDYCANE>(arg0, 0, b"COS", b"Mirthful Candy Cane", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Hand_Item_Mirthful_Candy_Cane.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIRTHFULCANDYCANE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIRTHFULCANDYCANE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

