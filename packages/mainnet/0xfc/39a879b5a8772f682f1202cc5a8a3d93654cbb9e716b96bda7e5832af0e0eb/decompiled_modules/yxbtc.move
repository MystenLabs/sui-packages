module 0xfc39a879b5a8772f682f1202cc5a8a3d93654cbb9e716b96bda7e5832af0e0eb::yxbtc {
    struct YXBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: YXBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YXBTC>(arg0, 8, b"yXBTC", b"Kai Vault xBTC", b"Kai Vault yield-bearing xBTC", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YXBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YXBTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

