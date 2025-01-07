module 0xdf31e35d84acb77b11f23ada00b22ec014ac18b92cf46f60f977825d18586ee::ang {
    struct ANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ANG>(arg0, 6, b"ANG", b"angrydad by SuiAI", b"angry dad is the best agent around", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/th_e55202d62c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

