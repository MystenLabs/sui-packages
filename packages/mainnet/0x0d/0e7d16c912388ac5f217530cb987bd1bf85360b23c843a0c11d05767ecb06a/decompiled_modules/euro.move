module 0xd0e7d16c912388ac5f217530cb987bd1bf85360b23c843a0c11d05767ecb06a::euro {
    struct EURO has drop {
        dummy_field: bool,
    }

    fun init(arg0: EURO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EURO>(arg0, 9, b"EURO", b"Euro", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EURO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EURO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

