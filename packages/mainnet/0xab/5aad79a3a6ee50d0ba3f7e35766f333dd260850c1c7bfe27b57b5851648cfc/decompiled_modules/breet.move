module 0xab5aad79a3a6ee50d0ba3f7e35766f333dd260850c1c7bfe27b57b5851648cfc::breet {
    struct BREET has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREET>(arg0, 6, b"BREET", b"Breeton Sui", b"Driven  mascot $BREET on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241010_130050_2e1dda4b0a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BREET>>(v1);
    }

    // decompiled from Move bytecode v6
}

