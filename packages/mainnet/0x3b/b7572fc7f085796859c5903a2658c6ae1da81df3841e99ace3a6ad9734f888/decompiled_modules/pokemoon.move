module 0x3bb7572fc7f085796859c5903a2658c6ae1da81df3841e99ace3a6ad9734f888::pokemoon {
    struct POKEMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEMOON>(arg0, 6, b"POKEMOON", b"Pokemoo", b"Your Favorite Childhood Game + Happy Hippo Moo Deng coming soon to SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_24_01_50_52_e12f88bb42.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POKEMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

