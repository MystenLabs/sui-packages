module 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::celer_wsteth_coin {
    struct CELER_WSTETH_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CELER_WSTETH_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CELER_WSTETH_COIN>(arg0, 9, b"wstETH", b"Wrapped liquid staked Ether 2.0", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CELER_WSTETH_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CELER_WSTETH_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

