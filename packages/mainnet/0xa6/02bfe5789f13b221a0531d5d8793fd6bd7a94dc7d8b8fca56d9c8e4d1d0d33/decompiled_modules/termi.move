module 0xa602bfe5789f13b221a0531d5d8793fd6bd7a94dc7d8b8fca56d9c8e4d1d0d33::termi {
    struct TERMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERMI>(arg0, 6, b"TERMI", b"Termi AI", b"$TERMI the first smart robot on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigcrtwfy3oyy4jayd5lqgdn52zngna3utbxyazuimrkvfse5aon4u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TERMI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

