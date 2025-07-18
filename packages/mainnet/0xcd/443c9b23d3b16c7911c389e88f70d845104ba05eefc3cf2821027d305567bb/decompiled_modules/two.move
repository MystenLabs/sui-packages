module 0xcd443c9b23d3b16c7911c389e88f70d845104ba05eefc3cf2821027d305567bb::two {
    struct TWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWO>(arg0, 6, b"TWO", b"MEWTWO", b"MEWTWO re-launch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidi3a2lnqc4lfg2tpcuuqyski4op7jfxv5e3w7fwsfdcv7aancfra")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TWO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

