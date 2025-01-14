module 0x89798716efb10dea79502f8fa1dec8ec3429fea01d836c66e5a89155d234f211::mirae {
    struct MIRAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIRAE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MIRAE>(arg0, 6, b"MIRAE", b"Mirae AI by SuiAI", b"The First AI Trading Bots Powered by DeFAI and Mindset Mastery.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Mirae_Logo_cb0e595a4a_54e85fa62e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MIRAE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIRAE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

