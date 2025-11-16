module 0xd2c040091ead0acf4e174db41893a6dd6b2603ce9cb1e8d36367a720de54ee77::nest {
    struct NEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEST>(arg0, 6, b"NEST", b"The Nest", b"The Nest Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

