module 0x66b5cb7c8f0f557594cbe0ea11f8732a95da4f828605f3405d3b12aa58d6b234::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 6, b"TRUMP", b"TRUMP AI", b"Welcome to the TRAIMP AI Terminal!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/solana/TrUPjEqGpUph6sMJX8C3yYja9u4RcVUGTCkGG4xLrjG.png?size=lg&key=c2ab30"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUMP>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

