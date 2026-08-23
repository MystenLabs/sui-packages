module 0xb00e8c97377223c22afd5d71fa231b59e242699997ba151dc7bcfada6f317d56::TEDS {
    struct TEDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEDS>(arg0, 9, b"TTT", b"TTT", b"Test-only Sui fungible token. Metadata and URL are placeholders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.redocn.com/sheji/20240905/keaixiaomaotupian_13402018.jpg")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TEDS>>(0x2::coin::mint<TEDS>(&mut v2, 1000000000 * 1000000000, arg1), v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEDS>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEDS>>(v1);
    }

    // decompiled from Move bytecode v7
}

