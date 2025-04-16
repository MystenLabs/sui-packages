module 0x16daec2351c04022970b6408745f5a41eb9feb4ffbccae482b1ddcf5777db374::yowei {
    struct YOWEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOWEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOWEI>(arg0, 6, b"Yowei", b"yowie", b"yowie on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib4jpb4yjjzzkiig727flgdtpy6cztivtn4vl4cpso4bmcsndbbne")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOWEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YOWEI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

