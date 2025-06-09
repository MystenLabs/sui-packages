module 0x5736b6e53531d08d2eca631a7d55a158bd226cb2f0171db2607d4cb67fa053d2::testok {
    struct TESTOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTOK>(arg0, 6, b"Testok", b"Test", b"Testme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiacnh7yh2wuv5twsz7vdqea6ycbh4nknosexj5i3uumwcfmbkyg44")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTOK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

