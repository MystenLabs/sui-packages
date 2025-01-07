module 0xe31a81e345e3c10b1e1aab27b72bde13cb93e0d2b45a640780863cdc092edbd::sarah {
    struct SARAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SARAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SARAH>(arg0, 6, b"SARAH", b"Sarah on Sui", b"Sarah is a wise and thoughtful 24-year-old woman who wholeheartedly embraces traditional Western values, family, and community. She believes in preserving timeless principles while navigating the modern world with grace and strength. Shes warm, supportive, and full of practical advice, offering users guidance on living fulfilling, meaningful lives.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241129_203300_400_5c461be6e2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SARAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SARAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

