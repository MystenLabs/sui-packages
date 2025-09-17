module 0xe20a042a9b6fed591f95770e09b91a5f835c65538f5d37c115dae8f8878eaaee::btcvc_zbtcvc_nevlp {
    struct BTCVC_ZBTCVC_NEVLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCVC_ZBTCVC_NEVLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCVC_ZBTCVC_NEVLP>(arg0, 8, b"nevLP-BTCvc-zBTCvc", b"nevLP-BTCvc-zBTCvc", b"nevLP-xBTC-wBTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://oss.nemoprotocol.com/vaultMMTBTCvczBTCvc.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTCVC_ZBTCVC_NEVLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCVC_ZBTCVC_NEVLP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

