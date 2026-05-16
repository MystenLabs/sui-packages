module 0xeaad568b3b7a06ee3158d84c26d367a5e5a97366c1670b816c6a4796c1da0d3f::figure {
    struct FIGURE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIGURE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIGURE>(arg0, 6, b"FIGURE", b"Figure", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FIGURE>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIGURE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FIGURE>>(v2);
    }

    // decompiled from Move bytecode v6
}

