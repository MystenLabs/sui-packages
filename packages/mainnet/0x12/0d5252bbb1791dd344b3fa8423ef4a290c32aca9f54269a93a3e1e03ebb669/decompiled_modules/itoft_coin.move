module 0x120d5252bbb1791dd344b3fa8423ef4a290c32aca9f54269a93a3e1e03ebb669::itoft_coin {
    struct ITOFT_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITOFT_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ITOFT_COIN>(arg0, 6, b"iTOFT", b"iTOFT", b"ItsTimeToOFT Sui OFT Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITOFT_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ITOFT_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

