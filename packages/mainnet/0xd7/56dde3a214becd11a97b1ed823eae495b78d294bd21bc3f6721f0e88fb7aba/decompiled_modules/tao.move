module 0xd756dde3a214becd11a97b1ed823eae495b78d294bd21bc3f6721f0e88fb7aba::tao {
    struct TAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAO>(arg0, 6, b"TAO", b"TAO Token", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TAO>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAO>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TAO>>(v2);
    }

    // decompiled from Move bytecode v6
}

