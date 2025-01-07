module 0x4f10b1c3a6e25705ed1841a02b2d11d19ed1b12591765db67e0e4aba6445a3a2::minos {
    struct MINOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINOS>(arg0, 6, b"MINOS", b"MINO Sui", b"MINO THE REAL SHIBA ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9134_9f3814c352.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

