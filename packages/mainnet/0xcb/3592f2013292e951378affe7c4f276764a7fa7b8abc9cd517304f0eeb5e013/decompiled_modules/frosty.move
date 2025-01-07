module 0xcb3592f2013292e951378affe7c4f276764a7fa7b8abc9cd517304f0eeb5e013::frosty {
    struct FROSTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROSTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROSTY>(arg0, 6, b"FROSTY", b"Frosty", b"Hi, I'm Frosty. I'm here to make Sui a better place ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagen_2025_01_03_152010401_89c89384a5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROSTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROSTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

