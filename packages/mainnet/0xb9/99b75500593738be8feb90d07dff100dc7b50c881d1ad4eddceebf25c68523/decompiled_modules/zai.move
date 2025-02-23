module 0xb999b75500593738be8feb90d07dff100dc7b50c881d1ad4eddceebf25c68523::zai {
    struct ZAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAI>(arg0, 6, b"ZAI", b"ZenAI", b"The future of AI meets the power of Sui!  Meet $ZAI  the most intelligent memecoin on the block, blending AI, memes, and unstoppable innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zen7_62e84ed2ee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

