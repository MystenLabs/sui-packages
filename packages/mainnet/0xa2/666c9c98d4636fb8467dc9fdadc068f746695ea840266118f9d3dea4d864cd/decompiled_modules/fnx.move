module 0xa2666c9c98d4636fb8467dc9fdadc068f746695ea840266118f9d3dea4d864cd::fnx {
    struct FNX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FNX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FNX>(arg0, 6, b"FNX", b"FINDEX LIQUIDITY TOKEN", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FNX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FNX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

