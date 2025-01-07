module 0x436e5b3ee224bab3b673653c1a525bbf920ccb9f302c9f18de2d5c8f32fe45d5::suitard {
    struct SUITARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITARD>(arg0, 6, b"SUITARD", b"Sui Retard", b"Just a retarded seal on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_08_at_4_17_01a_PM_32272faaf1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

