module 0x3d9a49f0d177068c421e1b92abd7d55a34044f6f431d185d7682ec2c4660ffe2::aurora {
    struct AURORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AURORA>(arg0, 6, b"AURORA", b"Aurora Sui", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AURORA>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AURORA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AURORA>>(v2);
    }

    // decompiled from Move bytecode v6
}

