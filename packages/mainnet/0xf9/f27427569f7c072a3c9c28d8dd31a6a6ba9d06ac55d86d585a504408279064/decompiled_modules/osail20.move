module 0xf9f27427569f7c072a3c9c28d8dd31a6a6ba9d06ac55d86d585a504408279064::osail20 {
    struct OSAIL20 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL20, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL20>(arg0, 6, b"oSAIL-20", b"oSAIL-20", b"Option Coin Full Sail Epoch 20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail20_test_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL20>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL20>>(v1);
    }

    // decompiled from Move bytecode v6
}

