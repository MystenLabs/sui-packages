module 0xec78991c9fddf38523eb7870aa404e2f66a4f99752cae97626c590355ad4fb3f::osail6 {
    struct OSAIL6 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL6>(arg0, 6, b"oSAIL-6", b"oSAIL-6", b"Option Coin Full Sail Epoch 6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail6_test_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL6>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL6>>(v1);
    }

    // decompiled from Move bytecode v6
}

