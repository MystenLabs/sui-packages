module 0x2e401b81b1d53653581b35206cc6c0dec2c844e1e52170e7b911e77628a963d9::osail12 {
    struct OSAIL12 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL12, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL12>(arg0, 6, b"oSAIL-12", b"oSAIL-12", b"Option Coin Full Sail Epoch 12", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail12_test_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL12>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL12>>(v1);
    }

    // decompiled from Move bytecode v6
}

