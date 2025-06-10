module 0xdf2f200e6efc745ca41667cf2b153dc6f5521b6d2f8e4d9340754bf52601b964::coke {
    struct COKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COKE>(arg0, 6, b"COKE", b"Cokizard", b"Trench trading got him addicted to coke, chasing highs in markets and nose", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihutlizir2w2wa3ftejbmliudkgj6ovdgdu2y5p4bufsjbtkp53gm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

