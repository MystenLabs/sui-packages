module 0xba646fa1ae22df4ab7b94d2305553209c6e894bbdfc9fb1d5f2d4715e3b349b3::aither {
    struct AITHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: AITHER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AITHER>(arg0, 6, b"AITHER", b"AI-therum", b"Introducing Aitherium SUI, a unique community-driven cryptocurrency designed to empower users in the realm of artificial intelligence (AI).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ai_therium_ce2ecec036.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AITHER>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AITHER>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

