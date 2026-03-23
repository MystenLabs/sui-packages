module 0xdcfe542bf8a929839aa4fedc9d09991aa568c935addaf1eadb2b7c05acc273e1::test_bub {
    struct TEST_BUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_BUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_BUB>(arg0, 9, b"tBUB", b"Test Bubcoin", b"Test token for Bubcoin game testing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bublz.fun/bubcoin.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_BUB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_BUB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

