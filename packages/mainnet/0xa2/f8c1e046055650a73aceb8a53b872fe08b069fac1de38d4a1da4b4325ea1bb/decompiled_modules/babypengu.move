module 0xa2f8c1e046055650a73aceb8a53b872fe08b069fac1de38d4a1da4b4325ea1bb::babypengu {
    struct BABYPENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYPENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYPENGU>(arg0, 6, b"BABYPENGU", b"Baby Pengu", b"BabyPengu has arrived on Sui! Don't miss out on the chance to own the cutest penguin in the world. BabyPengu's cuteness will melt your heart even if you're in the South Pole.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/profu_b9cf3c51a2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYPENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYPENGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

