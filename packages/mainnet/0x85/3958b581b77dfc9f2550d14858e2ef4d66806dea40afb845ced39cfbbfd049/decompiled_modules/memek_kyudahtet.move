module 0x853958b581b77dfc9f2550d14858e2ef4d66806dea40afb845ced39cfbbfd049::memek_kyudahtet {
    struct MEMEK_KYUDAHTET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_KYUDAHTET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_KYUDAHTET>(arg0, 6, b"MEMEKKYUDAHTET", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_KYUDAHTET>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_KYUDAHTET>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_KYUDAHTET>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

