module 0x668498d052202a7e0b780ee4ef109694f49448defe1cdd54e52bce3919db33c4::ada {
    struct ADA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADA>(arg0, 6, b"ADA", b"ADA on Sui", b"Ada on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif24vh56tn6g4uxpelsnoyyblrggrvwhhmowshvvzagsz5ytj25lm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ADA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

