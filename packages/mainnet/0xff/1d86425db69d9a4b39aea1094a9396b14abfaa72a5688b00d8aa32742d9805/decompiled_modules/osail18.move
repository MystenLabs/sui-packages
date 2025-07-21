module 0xff1d86425db69d9a4b39aea1094a9396b14abfaa72a5688b00d8aa32742d9805::osail18 {
    struct OSAIL18 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL18, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL18>(arg0, 6, b"oSAIL-18", b"oSAIL-18", b"Option Coin Full Sail Epoch 18", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail18_test_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL18>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL18>>(v1);
    }

    // decompiled from Move bytecode v6
}

