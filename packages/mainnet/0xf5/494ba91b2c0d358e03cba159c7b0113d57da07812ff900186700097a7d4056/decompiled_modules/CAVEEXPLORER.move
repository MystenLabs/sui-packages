module 0xf5494ba91b2c0d358e03cba159c7b0113d57da07812ff900186700097a7d4056::CAVEEXPLORER {
    struct CAVEEXPLORER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAVEEXPLORER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAVEEXPLORER>(arg0, 0, b"COS", b"CAVE EXPLORER", b"Limited-edition Aurahma swag from the Exclusive Battle Prototype event held in May 2023-the first playtesting experience for our Founding StarGarden holders-to those who plunged into the secret cave.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/CAVE_EXPLORER.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAVEEXPLORER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAVEEXPLORER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

