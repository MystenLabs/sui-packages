module 0xfef3c29b5de33b598bc149462f22c7da68367849ccb52b94731da0986649f82::testeth {
    struct TESTETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTETH>(arg0, 9, b"TestETH", b"Test ETH", b"Test Ethereum", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTETH>(&mut v2, 21000001000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTETH>>(v2, @0x189a6d439aec0317feadd9575e3a955b7b7e772907fa26696591090b3056527d);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTETH>>(v1);
    }

    // decompiled from Move bytecode v6
}

