module 0x97e022c9450b9f99ee16a2a3bdc055fde10c03e855a224f0419868a02aa7e7c8::yoo {
    struct YOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOO>(arg0, 9, b"YOO", b"yoo", b"yoo", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YOO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

