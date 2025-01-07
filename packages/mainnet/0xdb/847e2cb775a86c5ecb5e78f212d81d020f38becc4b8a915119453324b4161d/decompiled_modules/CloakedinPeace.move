module 0xdb847e2cb775a86c5ecb5e78f212d81d020f38becc4b8a915119453324b4161d::CloakedinPeace {
    struct CLOAKEDINPEACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOAKEDINPEACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOAKEDINPEACE>(arg0, 0, b"COS", b"Cloaked in Peace", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Cloaked_in_Peace.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLOAKEDINPEACE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOAKEDINPEACE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

