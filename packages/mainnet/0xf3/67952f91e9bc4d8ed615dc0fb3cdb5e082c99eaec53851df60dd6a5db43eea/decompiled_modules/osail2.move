module 0xf367952f91e9bc4d8ed615dc0fb3cdb5e082c99eaec53851df60dd6a5db43eea::osail2 {
    struct OSAIL2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL2>(arg0, 6, b"oSAIL-2", b"oSAIL-2", b"Option Coin Full Sail Epoch 2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail2_test_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL2>>(v1);
    }

    // decompiled from Move bytecode v6
}

