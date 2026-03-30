module 0x8dd9bb9264e26fd625df6e3a3a0c987701fc02fdaf01d6475492fcb6cbc4272b::bome {
    struct BOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOME>(arg0, 6, b"BOME", b"Book OF Meme", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOME>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOME>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BOME>>(v2);
    }

    // decompiled from Move bytecode v6
}

