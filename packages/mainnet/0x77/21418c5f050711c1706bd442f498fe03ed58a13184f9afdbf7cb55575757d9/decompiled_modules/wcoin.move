module 0x7721418c5f050711c1706bd442f498fe03ed58a13184f9afdbf7cb55575757d9::wcoin {
    struct WCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCOIN>(arg0, 8, b"WCOIN", b"WCOIN", b"this is wcoin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCOIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<WCOIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

