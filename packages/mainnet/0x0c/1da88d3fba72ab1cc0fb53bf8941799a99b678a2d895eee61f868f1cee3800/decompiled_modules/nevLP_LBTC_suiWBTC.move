module 0xc1da88d3fba72ab1cc0fb53bf8941799a99b678a2d895eee61f868f1cee3800::nevLP_LBTC_suiWBTC {
    struct NEVLP_LBTC_SUIWBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEVLP_LBTC_SUIWBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEVLP_LBTC_SUIWBTC>(arg0, 8, b"sy-nevLP-LBTC-suiWBTC", b"SY nevLP-LBTC-suiWBTC", b"SY nevLP-LBTC-suiWBTC", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEVLP_LBTC_SUIWBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEVLP_LBTC_SUIWBTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

