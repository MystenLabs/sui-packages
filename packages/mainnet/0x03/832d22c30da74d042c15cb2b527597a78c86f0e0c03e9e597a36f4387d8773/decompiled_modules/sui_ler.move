module 0x3832d22c30da74d042c15cb2b527597a78c86f0e0c03e9e597a36f4387d8773::sui_ler {
    struct SUI_LER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_LER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_LER>(arg0, 6, b"SUILER", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_LER>>(v1);
        0x2::coin::mint_and_transfer<SUI_LER>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_LER>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

