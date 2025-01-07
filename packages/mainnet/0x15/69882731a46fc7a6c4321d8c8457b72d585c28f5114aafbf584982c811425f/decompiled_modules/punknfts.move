module 0x1569882731a46fc7a6c4321d8c8457b72d585c28f5114aafbf584982c811425f::punknfts {
    struct PUNKNFTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUNKNFTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUNKNFTS>(arg0, 6, b"PUNKNFTS", b"PUNKNFTSONSUI", x"5468697320697320746865206e657720746f6b656e0a0a5765206172652072656272616e64696e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5256_0754a7c72c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUNKNFTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUNKNFTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

