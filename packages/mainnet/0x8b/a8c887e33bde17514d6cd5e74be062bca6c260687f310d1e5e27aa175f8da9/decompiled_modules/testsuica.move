module 0x8ba8c887e33bde17514d6cd5e74be062bca6c260687f310d1e5e27aa175f8da9::testsuica {
    struct TESTSUICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTSUICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTSUICA>(arg0, 9, b"TESTSUICA", b"TESTSUICA ", b"TESTSUICA  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://gateway.pinata.cloud/ipfs/QmX5f5w6WymDaxyfoYX8Tnw43HMsHCxCpUVsLxP3ATHEQZ"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTSUICA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTSUICA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

