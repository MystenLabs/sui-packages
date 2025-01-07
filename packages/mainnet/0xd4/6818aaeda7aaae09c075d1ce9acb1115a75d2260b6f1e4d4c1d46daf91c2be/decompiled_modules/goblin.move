module 0xd46818aaeda7aaae09c075d1ce9acb1115a75d2260b6f1e4d4c1d46daf91c2be::goblin {
    struct GOBLIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOBLIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOBLIN>(arg0, 6, b"Goblin", b"Goblin on sui", b"Explore the mystical world of goblin. Supernatural creatures that have fascinated people for centuries. Learn about their origins, powers, and appearances in folklore and literature", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_08_11_20_43_22_2784c6b4f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOBLIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOBLIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

