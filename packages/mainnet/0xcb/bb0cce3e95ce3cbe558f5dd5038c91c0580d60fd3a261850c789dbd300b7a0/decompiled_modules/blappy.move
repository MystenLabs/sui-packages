module 0xcbbb0cce3e95ce3cbe558f5dd5038c91c0580d60fd3a261850c789dbd300b7a0::blappy {
    struct BLAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAPPY>(arg0, 6, b"BLAPPY", b"BLAPPY SUI", b"Only Flyyyuyy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7047_e28bd10ca1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLAPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

