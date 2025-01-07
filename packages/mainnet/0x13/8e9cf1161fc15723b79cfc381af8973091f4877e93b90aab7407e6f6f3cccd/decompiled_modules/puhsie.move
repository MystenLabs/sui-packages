module 0x138e9cf1161fc15723b79cfc381af8973091f4877e93b90aab7407e6f6f3cccd::puhsie {
    struct PUHSIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUHSIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUHSIE>(arg0, 6, b"PUHSIE", b"Hiding Puhsie", b"Can you find Puhsie?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1107_94bcb4c7e9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUHSIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUHSIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

