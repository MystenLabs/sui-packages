module 0xa6c5783601bd5c2c2595def52b92997ac83468e932cf7185ed1c1bd5d4d5393::osail15 {
    struct OSAIL15 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL15, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL15>(arg0, 6, b"oSAIL-15", b"oSAIL-15", b"Option Coin Full Sail Epoch 15", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail15_test_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL15>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL15>>(v1);
    }

    // decompiled from Move bytecode v6
}

