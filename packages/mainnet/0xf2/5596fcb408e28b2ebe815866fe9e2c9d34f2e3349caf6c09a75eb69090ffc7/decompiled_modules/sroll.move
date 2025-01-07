module 0xf25596fcb408e28b2ebe815866fe9e2c9d34f2e3349caf6c09a75eb69090ffc7::sroll {
    struct SROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SROLL>(arg0, 6, b"SROLL", b"Sui Troll", b"Meet $SROLL, the Sui Troll. An ancient beast from the depths of Sui, guarding its territory and treasure with brute strength and clever tricks. Challenge it, and you might find rewards or end up as just another tale in its legend. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_79_65f384298e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SROLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SROLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

