module 0x8c393c2b60965f88051d9f49aed19f5ef82725d38685575bac544c58a836043a::spark {
    struct SPARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPARK>(arg0, 9, b"Spark", b"Spark Spark ", b"DeputySecState hosted a press briefing together with Japanese Ambassador to the U.S., Shigeo Yamada, to highlight the @USA_Pavilion_ at #EXPO2025 including the public reveal of the USA Pavilion mascot, Spark.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreiamvhuvvx3rffzni5h6ehcn7t6x6u5r5oymwhnloopqovkm2bchpa.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPARK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPARK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPARK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

