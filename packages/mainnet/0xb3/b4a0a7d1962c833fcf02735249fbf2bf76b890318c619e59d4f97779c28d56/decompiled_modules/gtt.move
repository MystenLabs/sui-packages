module 0xb3b4a0a7d1962c833fcf02735249fbf2bf76b890318c619e59d4f97779c28d56::gtt {
    struct GTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTT>(arg0, 6, b"GTT", b"GasTestToken", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GTT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

