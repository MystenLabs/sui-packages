module 0x2a9a3474683292a9f88e5a404c191db5b7e9c8017380344d1ebc0d68caa3f369::qwrdxercoin {
    struct QWRDXERCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: QWRDXERCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QWRDXERCOIN>(arg0, 6, b"QWRDXERCOIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QWRDXERCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QWRDXERCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<QWRDXERCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<QWRDXERCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

