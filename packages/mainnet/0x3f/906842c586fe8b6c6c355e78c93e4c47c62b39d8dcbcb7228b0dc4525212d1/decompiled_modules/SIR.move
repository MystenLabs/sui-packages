module 0x3f906842c586fe8b6c6c355e78c93e4c47c62b39d8dcbcb7228b0dc4525212d1::SIR {
    struct SIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIR>(arg0, 9, b"PLEASE", b"Please return money", b"I made 2 liquidity pools by mistake. I request you to please refund the 134 Sui you earned from it. PLEASE!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x44171cbbfa69aba3d0a3fd91ab3c979900c620e9.png?size=xl&key=327e8d")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SIR>>(0x2::coin::mint<SIR>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SIR>>(v2);
    }

    // decompiled from Move bytecode v6
}

