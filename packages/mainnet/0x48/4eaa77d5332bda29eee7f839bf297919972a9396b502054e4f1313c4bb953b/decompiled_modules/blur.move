module 0x484eaa77d5332bda29eee7f839bf297919972a9396b502054e4f1313c4bb953b::blur {
    struct BLUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUR>(arg0, 9, b"BLUR", b"Wrapped Blur", b"ABEx Virtual Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUR>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BLUR>>(v0);
    }

    // decompiled from Move bytecode v6
}

