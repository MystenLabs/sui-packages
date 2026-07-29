module 0xb547c9b984fc6ab0ad56aeecba3b28f685cdcce288ca2d4801bf200b0b082b85::svbtc {
    struct SVBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SVBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SVBTC>(arg0, 8, b"SVBTC", b"Svalbard BTC", b"Sui LayerZero OFT representation of Svalbard BTC.", 0x1::option::none<0x2::url::Url>(), true, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SVBTC>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SVBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SVBTC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

