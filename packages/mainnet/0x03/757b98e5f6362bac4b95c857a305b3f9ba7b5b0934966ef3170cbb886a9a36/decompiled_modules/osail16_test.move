module 0x3757b98e5f6362bac4b95c857a305b3f9ba7b5b0934966ef3170cbb886a9a36::osail16_test {
    struct OSAIL16_TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL16_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL16_TEST>(arg0, 6, b"oSAIL-16-TEST", b"oSAIL-16-TEST", b"Option Coin Full Sail Epoch 16 Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail16_test_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL16_TEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL16_TEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

