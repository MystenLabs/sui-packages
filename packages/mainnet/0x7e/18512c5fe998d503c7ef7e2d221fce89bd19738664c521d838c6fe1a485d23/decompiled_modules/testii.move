module 0x7e18512c5fe998d503c7ef7e2d221fce89bd19738664c521d838c6fe1a485d23::testii {
    struct TESTII has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTII>(arg0, 6, b"Testii", b"test", b"dont buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig6p63ymaojntajfbo76fd4pec2j5g6xquylg4bpwqzmrafjpdlwy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTII>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

