module 0x36903ca4bf06cce628a444275d91522f22616285fa65d2ff5a1d2fffa4caab86::osail11 {
    struct OSAIL11 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL11, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL11>(arg0, 6, b"oSAIL-11", b"oSAIL-11", b"Option Coin Full Sail Epoch 11", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail11_test_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL11>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL11>>(v1);
    }

    // decompiled from Move bytecode v6
}

