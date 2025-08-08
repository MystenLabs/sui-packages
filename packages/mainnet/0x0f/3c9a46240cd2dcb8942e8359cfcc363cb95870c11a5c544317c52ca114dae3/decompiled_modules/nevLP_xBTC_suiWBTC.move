module 0xf3c9a46240cd2dcb8942e8359cfcc363cb95870c11a5c544317c52ca114dae3::nevLP_xBTC_suiWBTC {
    struct NEVLP_XBTC_SUIWBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEVLP_XBTC_SUIWBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEVLP_XBTC_SUIWBTC>(arg0, 8, b"sy-nevLP-xBTC-suiWBTC", b"SY nevLP-xBTC-suiWBTC", b"SY nevLP-xBTC-suiWBTC", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEVLP_XBTC_SUIWBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEVLP_XBTC_SUIWBTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

