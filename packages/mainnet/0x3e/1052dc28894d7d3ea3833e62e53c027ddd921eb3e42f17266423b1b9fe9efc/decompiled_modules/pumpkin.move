module 0x3e1052dc28894d7d3ea3833e62e53c027ddd921eb3e42f17266423b1b9fe9efc::pumpkin {
    struct PUMPKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PUMPKIN>(arg0, 6, b"PUMPKIN", b"PUMPKIN TOKEN by SuiAI", b"Once a humble cat, Pumpkin became a hero when his curious scratch led to an unexpected trip to the hospital for his owner. What seemed like a minor incident turned into a life-saving moment as doctors discovered a severe condition caused by long-term addiction. Thanks to Pumpkin's playful nudge,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Pumpkin_Token_Best_909a3d3335_d859304fbf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUMPKIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPKIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

