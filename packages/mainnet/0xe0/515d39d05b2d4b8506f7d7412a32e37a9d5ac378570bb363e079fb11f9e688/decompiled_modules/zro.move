module 0xe0515d39d05b2d4b8506f7d7412a32e37a9d5ac378570bb363e079fb11f9e688::zro {
    struct ZRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZRO>(arg0, 9, b"ZRO", b"LayerZero", b"LayerZero", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZRO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

