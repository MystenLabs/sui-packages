module 0xb2088ebe32748759cbf324171cdcf7b2d66ac977a69f8d1b428b8d1db1433f66::coin_utils {
    struct COIN_UTILS has drop {
        dummy_field: bool,
    }

    public entry fun coin_mint(arg0: &mut 0x2::coin::TreasuryCap<COIN_UTILS>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<COIN_UTILS>>(0x2::coin::mint<COIN_UTILS>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: COIN_UTILS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_UTILS>(arg0, 6, b"DC", b"DemoCoin", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COIN_UTILS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_UTILS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

