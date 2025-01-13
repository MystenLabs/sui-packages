module 0x81cb817ad280c13ad7c2f3f7a64d90b28e2057e1e08014f656a0862e787918b0::aiz {
    struct AIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIZ>(arg0, 6, b"AIZ", b"aiz by SuiAI", b"AI led hedge fun / open-source AGI movement", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/5o_DI_Me7d_400x400_c60c70020c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIZ>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIZ>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

