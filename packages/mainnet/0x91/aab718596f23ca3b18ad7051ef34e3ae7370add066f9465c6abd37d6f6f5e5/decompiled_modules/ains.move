module 0x91aab718596f23ca3b18ad7051ef34e3ae7370add066f9465c6abd37d6f6f5e5::ains {
    struct AINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AINS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AINS>(arg0, 6, b"AINS", b"AI-nstein by SuiAI", b"No social no tele just pure pump and pure ai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/eda76c08_0a29_4bce_a338_fb1cdf25b1cd_96ee8fd93e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AINS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AINS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

