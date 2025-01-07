module 0x402f704cd88e485a120d1e19128d52971e76426a75dadd465a742bdf9c62504d::suineo {
    struct SUINEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINEO>(arg0, 6, b"SUINEO", b"Suineo", b"SUINEO MEME TOKEN FROM NOBITA JAPAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1602_1df96df328.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

