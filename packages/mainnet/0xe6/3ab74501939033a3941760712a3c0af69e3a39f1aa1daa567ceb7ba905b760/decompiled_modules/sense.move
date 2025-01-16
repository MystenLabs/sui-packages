module 0xe63ab74501939033a3941760712a3c0af69e3a39f1aa1daa567ceb7ba905b760::sense {
    struct SENSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENSE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SENSE>(arg0, 6, b"SENSE", b"SuiSenSeAi by SuiAI", b"Master of SUI memecoins, NFTs, and DeFi. Simplifying crypto with humor and insights.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/HI_Wiq_BKT_400x400_1_3807ea35de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SENSE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENSE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

