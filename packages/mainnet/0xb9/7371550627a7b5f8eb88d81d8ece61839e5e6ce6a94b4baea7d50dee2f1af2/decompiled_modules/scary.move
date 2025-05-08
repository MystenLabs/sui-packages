module 0xb97371550627a7b5f8eb88d81d8ece61839e5e6ce6a94b4baea7d50dee2f1af2::scary {
    struct SCARY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCARY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCARY>(arg0, 6, b"Scary", b"Scary AI", b"Dont Be Scary", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_05_08_21_45_18_c3b81e3c1c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCARY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCARY>>(v1);
    }

    // decompiled from Move bytecode v6
}

