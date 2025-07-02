module 0xa5d5e7edd35ba0b149d72f758fb659779d95182b17e469814decb6ac225948e0::osail {
    struct OSAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL>(arg0, 6, b"oSAIL-1", b"oSAIL-1", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail_test_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

