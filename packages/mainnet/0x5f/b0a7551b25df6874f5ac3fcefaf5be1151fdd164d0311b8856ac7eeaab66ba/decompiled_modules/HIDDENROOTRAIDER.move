module 0x5fb0a7551b25df6874f5ac3fcefaf5be1151fdd164d0311b8856ac7eeaab66ba::HIDDENROOTRAIDER {
    struct HIDDENROOTRAIDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIDDENROOTRAIDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIDDENROOTRAIDER>(arg0, 0, b"COS", b"HIDDEN ROOT RAIDER", b"Limited-edition Aurahma swag from the Exclusive Battle Prototype event held in May 2023-the first playtesting experience for our Founding StarGarden holders-to those who discovered the hidden battles.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/HIDDEN_ROOT_RAIDER.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIDDENROOTRAIDER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIDDENROOTRAIDER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

