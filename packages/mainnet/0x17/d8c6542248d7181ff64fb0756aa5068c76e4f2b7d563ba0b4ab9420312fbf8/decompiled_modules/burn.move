module 0x17d8c6542248d7181ff64fb0756aa5068c76e4f2b7d563ba0b4ab9420312fbf8::burn {
    struct BURN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURN>(arg0, 6, b"Burn", b"Black Whole", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BURN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

