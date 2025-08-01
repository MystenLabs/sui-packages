module 0x2d2c6d00cac22d5062607b1a40c7365c5a65bc2b58e9edb9fdae476a342b00a9::nttt {
    struct NTTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTTT>(arg0, 6, b"NTTT", b"Test NTT token", b"Test NTT token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NTTT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTTT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

