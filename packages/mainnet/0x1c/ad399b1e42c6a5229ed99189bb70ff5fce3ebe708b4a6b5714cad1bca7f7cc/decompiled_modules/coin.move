module 0x1cad399b1e42c6a5229ed99189bb70ff5fce3ebe708b4a6b5714cad1bca7f7cc::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN>(arg0, 8, b"COIN", b"Wrapped token for COINBASE INC", b"Sudo Virtual Coin for COINBASE INC", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

