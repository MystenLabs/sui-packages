module 0xb18a93d0f6c4a5537d1884cb0c461beb6da44751c00ae210a802e8d1a772dfe8::SUIEP {
    struct SUIEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEP>(arg0, 9, b"SUIEP", b"SuiGameEquityPoints", b"SuiGame Equity Points", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIEP>>(v1);
        0x2::coin::mint_and_transfer<SUIEP>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIEP>>(v2);
    }

    // decompiled from Move bytecode v6
}

