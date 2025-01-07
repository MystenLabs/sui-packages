module 0x733b397727ac273833a521a70da7e607936ebe44500e4a23f36ec47dc42a0173::memek_andi {
    struct MEMEK_ANDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_ANDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_ANDI>(arg0, 6, b"MEMEKANDI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_ANDI>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_ANDI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_ANDI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

