module 0xfe0dea97386199216fbee9d70ab4cf45d862d6c6a4aaa577a6e518aced9a8f6b::golden_cat {
    struct GOLDEN_CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDEN_CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDEN_CAT>(arg0, 6, b"GOLDEN CAT", b"TheGoldenCAT", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOLDEN_CAT>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOLDEN_CAT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GOLDEN_CAT>>(v2);
    }

    // decompiled from Move bytecode v6
}

