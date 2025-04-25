module 0x7e9d9072b8bdea0ca0b9fc709ec008966dacf1918228e01787f32cd53922a2ea::star {
    struct STAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAR>(arg0, 6, b"STAR", b"STAR CLASH", b"Star Clash: Battle of Icons is an epic NFT game where the greatest personalities of humanity transform into legendary fighters! Collect exclusive digital collections featuring three iconic types of characters: artists, singers, and politicians.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_368ad628a9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

