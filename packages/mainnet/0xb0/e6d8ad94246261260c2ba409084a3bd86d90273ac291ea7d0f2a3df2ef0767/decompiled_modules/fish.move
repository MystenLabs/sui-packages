module 0xb0e6d8ad94246261260c2ba409084a3bd86d90273ac291ea7d0f2a3df2ef0767::fish {
    struct FISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISH>(arg0, 6, b"FISH", b"littlefish", b"Dive into the world of LittleFish, the newest meme token making a splash on the SUI network! Inspired by the playful nature of our aquatic friends, LittleFish is not just another token; it's a vibrant community-driven movement that embodies fun, creativity, and the spirit of innovation in the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/littlefish_transparent_a2b11e0f91.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

