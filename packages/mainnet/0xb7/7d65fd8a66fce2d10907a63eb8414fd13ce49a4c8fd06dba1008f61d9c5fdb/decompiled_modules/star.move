module 0xb77d65fd8a66fce2d10907a63eb8414fd13ce49a4c8fd06dba1008f61d9c5fdb::star {
    struct STAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAR>(arg0, 6, b"STAR", b"Star Clash", b"Star Clash: Battle of Icons is an NFT game where the greatest personalities of humanity transform into legendary fighters! Collect exclusive digital collections featuring three iconic types of characters: artists, singers, and politicians. Each hero boasts unique abilities and a distinct fighting style, making every battle a true test of strategy and skill. Your collection is your path to glory!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bg_547cfd667b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

