module 0xba065bcb5117b132f6b6c617d7b7d702b3ead4bd285c3c6fc1e971b822d8c214::osail3 {
    struct OSAIL3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL3>(arg0, 6, b"oSAIL-3", b"oSAIL-3", b"Option Coin Full Sail Epoch 3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail3_test_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL3>>(v1);
    }

    // decompiled from Move bytecode v6
}

