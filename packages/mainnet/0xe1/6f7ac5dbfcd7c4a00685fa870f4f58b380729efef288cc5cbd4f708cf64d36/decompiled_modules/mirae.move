module 0xe16f7ac5dbfcd7c4a00685fa870f4f58b380729efef288cc5cbd4f708cf64d36::mirae {
    struct MIRAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIRAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIRAE>(arg0, 6, b"MIRAE", b"Mirae SUI", b"The First AI Trading Bots Powered by DeFAI and Mindset Mastery.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250116_121842_482_37c340ab58.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIRAE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIRAE>>(v1);
    }

    // decompiled from Move bytecode v6
}

