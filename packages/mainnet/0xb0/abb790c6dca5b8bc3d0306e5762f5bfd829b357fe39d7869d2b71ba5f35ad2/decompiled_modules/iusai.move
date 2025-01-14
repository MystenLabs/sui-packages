module 0xb0abb790c6dca5b8bc3d0306e5762f5bfd829b357fe39d7869d2b71ba5f35ad2::iusai {
    struct IUSAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IUSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<IUSAI>(arg0, 6, b"IUSAI", b"IUS AI by SuiAI", b"Ius Ai isn't just about humor; it's a tool for visibility in the crowded digital landscape, aiming to make blockchain technology accessible and fun. Whether you're a crypto enthusiast looking to make your mark, or a brand aiming to tap into the crypto-meme zeitgeist, Ius Ai offers a unique blend of creativity, technology, and community engagement. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ius_4352617a1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IUSAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IUSAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

