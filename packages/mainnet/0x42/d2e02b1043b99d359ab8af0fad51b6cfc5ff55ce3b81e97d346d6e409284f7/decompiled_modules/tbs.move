module 0x42d2e02b1043b99d359ab8af0fad51b6cfc5ff55ce3b81e97d346d6e409284f7::tbs {
    struct TBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBS>(arg0, 6, b"Tbs", b"TESBTC", b"Loking chart", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihipr7bvybl2cjaryzsdweht3d5konuo3mh6ijwrolje7ljcekmfi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TBS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

