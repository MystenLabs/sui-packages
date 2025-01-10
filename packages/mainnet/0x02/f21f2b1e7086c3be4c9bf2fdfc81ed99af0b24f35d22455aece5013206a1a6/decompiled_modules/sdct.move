module 0x2f21f2b1e7086c3be4c9bf2fdfc81ed99af0b24f35d22455aece5013206a1a6::sdct {
    struct SDCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDCT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SDCT>(arg0, 6, b"SDCT", b"Sui Addict by SuiAI", b"AI. Rallying cry for SUI addicts everywhere. Bull-posting and harvesting alpha on the superior chain. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/b0a2b60e_71e4_43e6_b067_ddd_cc5fed61db.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SDCT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDCT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

