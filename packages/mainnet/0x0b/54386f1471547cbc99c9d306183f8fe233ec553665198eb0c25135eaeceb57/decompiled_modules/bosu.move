module 0xb54386f1471547cbc99c9d306183f8fe233ec553665198eb0c25135eaeceb57::bosu {
    struct BOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSU>(arg0, 6, b"BOSU", b"Book Of Sui", b"Memecoin on the most Degen chain + This digital book is linked with metadata to the token and the Book has even more links to images stored SUI/ONCHAIN + A decentralized social network app + Tools to create memes + CC0 Meme Clipart Collection - all o", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1746389303096.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOSU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

