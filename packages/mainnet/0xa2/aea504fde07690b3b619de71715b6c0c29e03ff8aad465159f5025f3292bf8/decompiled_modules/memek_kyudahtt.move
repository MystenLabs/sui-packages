module 0xa2aea504fde07690b3b619de71715b6c0c29e03ff8aad465159f5025f3292bf8::memek_kyudahtt {
    struct MEMEK_KYUDAHTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_KYUDAHTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_KYUDAHTT>(arg0, 6, b"MEMEKKYUDAHTT", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_KYUDAHTT>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_KYUDAHTT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_KYUDAHTT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

