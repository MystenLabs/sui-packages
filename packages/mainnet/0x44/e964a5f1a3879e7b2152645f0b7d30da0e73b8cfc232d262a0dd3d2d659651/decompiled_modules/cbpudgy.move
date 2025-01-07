module 0x44e964a5f1a3879e7b2152645f0b7d30da0e73b8cfc232d262a0dd3d2d659651::cbpudgy {
    struct CBPUDGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBPUDGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBPUDGY>(arg0, 6, b"cbPUDGY", b"PUDGY", b"Pudgy, the new mascot of Sui, is an adorable, round-bellied penguin with a playful personality. Inspired by The new CB Tweet Pudgy is here to take base by storm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image01_f6c9d9ee02.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBPUDGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CBPUDGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

