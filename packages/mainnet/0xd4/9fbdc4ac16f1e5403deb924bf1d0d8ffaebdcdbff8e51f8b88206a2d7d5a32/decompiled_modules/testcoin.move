module 0xd49fbdc4ac16f1e5403deb924bf1d0d8ffaebdcdbff8e51f8b88206a2d7d5a32::testcoin {
    struct TESTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTCOIN>(arg0, 0, b"TESTCOIN", b"Test Coin", x"546865206f6e6c7920636f696e20746861742070726f6d6973657320746f207465737420796f75722070617469656e6365206265666f72652069742074616b6573206f6666e280946c696b652077616974696e6720666f72206469616c2d757020746f20636f6e6e65637420696e20746865202739307321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://v3.fal.media/files/lion/896Az76riAuTpvIoBEo6S.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

