module 0x42b5d97a10059c9e8d881fd9c6366d29b000ac080d718508164d4f59c163b34e::sscat {
    struct SSCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSCAT>(arg0, 6, b"Sscat", b"SpriteCat On Sui", b"Introducing SpriteCat  Dive into the pixelated world of SpriteCat, the ultimate crypto mascot designed to bring fun and fortune to your sui wallet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sprite_Cat_logo_8442767a87.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

