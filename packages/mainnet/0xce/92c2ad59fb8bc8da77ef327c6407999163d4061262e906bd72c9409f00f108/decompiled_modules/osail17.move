module 0xce92c2ad59fb8bc8da77ef327c6407999163d4061262e906bd72c9409f00f108::osail17 {
    struct OSAIL17 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL17, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL17>(arg0, 6, b"oSAIL-17", b"oSAIL-17", b"Option Coin Full Sail Epoch 17", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail17_test_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL17>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL17>>(v1);
    }

    // decompiled from Move bytecode v6
}

