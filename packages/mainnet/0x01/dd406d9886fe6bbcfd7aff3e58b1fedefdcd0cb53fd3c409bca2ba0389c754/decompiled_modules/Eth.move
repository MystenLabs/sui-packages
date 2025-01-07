module 0x1dd406d9886fe6bbcfd7aff3e58b1fedefdcd0cb53fd3c409bca2ba0389c754::Eth {
    struct ETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETH>(arg0, 8, b"ETH", b"ETH", b"ETH", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ETH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

