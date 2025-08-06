module 0x112e1188784b6281b692ef54efeb4e2014de348d31c6651e62e6894643145d95::suithlnk {
    struct SUITHLNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITHLNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITHLNK>(arg0, 6, b"SuiThlnk", b"Sui Think", b"\"Thlnk Less. Hold More. $SuiThlnk\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidvq5k4th2ehlg3eb2xgqsjbvm5thoa4wwz3rsyfz4uv63rkcvk5q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITHLNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUITHLNK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

