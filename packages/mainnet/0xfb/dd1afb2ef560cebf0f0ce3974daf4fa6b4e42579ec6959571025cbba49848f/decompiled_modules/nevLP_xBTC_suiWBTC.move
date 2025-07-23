module 0xfbdd1afb2ef560cebf0f0ce3974daf4fa6b4e42579ec6959571025cbba49848f::nevLP_xBTC_suiWBTC {
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

