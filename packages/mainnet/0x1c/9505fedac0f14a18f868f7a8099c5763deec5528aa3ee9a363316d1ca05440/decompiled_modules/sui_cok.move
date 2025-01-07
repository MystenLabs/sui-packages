module 0x1c9505fedac0f14a18f868f7a8099c5763deec5528aa3ee9a363316d1ca05440::sui_cok {
    struct SUI_COK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_COK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_COK>(arg0, 6, b"SUICOK", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_COK>>(v1);
        0x2::coin::mint_and_transfer<SUI_COK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_COK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

