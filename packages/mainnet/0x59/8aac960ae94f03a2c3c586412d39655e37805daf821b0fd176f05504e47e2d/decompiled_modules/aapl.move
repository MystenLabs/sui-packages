module 0x598aac960ae94f03a2c3c586412d39655e37805daf821b0fd176f05504e47e2d::aapl {
    struct AAPL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAPL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAPL>(arg0, 8, b"AAPL", b"Wrapped token for Apple Inc.", b"Sudo Virtual Coin for Apple Inc.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAPL>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AAPL>>(v0);
    }

    // decompiled from Move bytecode v6
}

