module 0xdba78d2a30d6cc507e437404b0940cb051074758350443cb9f7fee815b87edae::hero {
    struct HERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HERO>(arg0, 6, b"HERO", b"HERO", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HERO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HERO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

