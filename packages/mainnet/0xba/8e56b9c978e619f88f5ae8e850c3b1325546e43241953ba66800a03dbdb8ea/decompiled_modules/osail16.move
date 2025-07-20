module 0xba8e56b9c978e619f88f5ae8e850c3b1325546e43241953ba66800a03dbdb8ea::osail16 {
    struct OSAIL16 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL16, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL16>(arg0, 6, b"oSAIL-16", b"oSAIL-16", b"Option Coin Full Sail Epoch 16", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail16_test_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL16>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL16>>(v1);
    }

    // decompiled from Move bytecode v6
}

