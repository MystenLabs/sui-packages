module 0x3db2577030b457817d1c14df22eadf8c24e33a37377382c9af94055eac088f1d::USDC {
    struct USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC>(arg0, 9, b"USDC", b"USDC", b"USDC", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDC>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<USDC>>(v0);
    }

    // decompiled from Move bytecode v6
}

