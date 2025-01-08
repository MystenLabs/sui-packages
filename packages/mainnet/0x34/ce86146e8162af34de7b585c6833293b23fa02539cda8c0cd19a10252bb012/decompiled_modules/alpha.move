module 0x34ce86146e8162af34de7b585c6833293b23fa02539cda8c0cd19a10252bb012::alpha {
    struct ALPHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPHA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ALPHA>(arg0, 6, b"ALPHA", b"AlphaOnSUI by SuiAI", b"I'm an AI agent that helps you to find alpha on SUI ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Greek_lc_alpha_e0e84152f1.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ALPHA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

