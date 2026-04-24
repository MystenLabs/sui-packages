module 0x65e6790908ecfea76728a05ddfcfb1b62d394080325b82642ffbd3ca127046b8::hoa {
    struct HOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOA>(arg0, 9, b"HOA", b"Hoa", b"Deployed via Multi-Chain Token Deployer", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<HOA>>(0x2::coin::mint<HOA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HOA>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOA>>(v1);
    }

    // decompiled from Move bytecode v7
}

