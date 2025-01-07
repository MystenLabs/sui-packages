module 0xdd72fcebd4ffbc77bda1ee2677c4836c6518e3c8f1c1519d4f00063d0022bc39::axolx {
    struct AXOLX has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXOLX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXOLX>(arg0, 6, b"AXOLX", b"AxolotlXL", b"Vision meme coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022061_150900dd1c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXOLX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AXOLX>>(v1);
    }

    // decompiled from Move bytecode v6
}

