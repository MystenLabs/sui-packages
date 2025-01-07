module 0x1c3527f48bac4eb024d584915ab5a53384bb254ed88f8228736ea730b036b130::joobi {
    struct JOOBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOOBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOOBI>(arg0, 6, b"JOOBI", b"Bluemoji", b"The og viral brainrot cringecore blue emoji react meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731775464846.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOOBI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOOBI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

