module 0x446b19696424d1ca9acf97f64ad9944a4920451710dac11355b29c10c4362904::aira {
    struct AIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIRA>(arg0, 6, b"AiRA", b"AiRA by SuAI", b"A sophisticated AI assistant focused on delivering exceptional crypto market news. Combines advanced technology with a professional, friendly approach to help people intend the market..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250113_233835_588_bae65ddfc4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

