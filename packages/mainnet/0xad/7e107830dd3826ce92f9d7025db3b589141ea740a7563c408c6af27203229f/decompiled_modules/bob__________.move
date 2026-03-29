module 0xad7e107830dd3826ce92f9d7025db3b589141ea740a7563c408c6af27203229f::bob__________ {
    struct BOB__________ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOB__________, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOB__________>(arg0, 6, b"Token", b"Token Name", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOB__________>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOB__________>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

