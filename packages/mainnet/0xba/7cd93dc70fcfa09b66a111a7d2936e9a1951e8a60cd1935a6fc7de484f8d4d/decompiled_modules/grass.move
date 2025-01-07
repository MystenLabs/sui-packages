module 0xba7cd93dc70fcfa09b66a111a7d2936e9a1951e8a60cd1935a6fc7de484f8d4d::grass {
    struct GRASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRASS>(arg0, 6, b"GRASS", b"Grass", b"This is just parody of official Grass on Solana. Do not buy or it will pump!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/128x128_1e4ae45f9c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

