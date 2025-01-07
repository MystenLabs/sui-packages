module 0xe7801d04c08d247da1699b4a319f01eaf6d4fb9b4293ec1fdb9c6b21bb503f46::mtest {
    struct MTEST has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MTEST>, arg1: 0x2::coin::Coin<MTEST>) {
        0x2::coin::burn<MTEST>(arg0, arg1);
    }

    fun init(arg0: MTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTEST>(arg0, 9, b"mtest", b"MTEST", b"my test coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MTEST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MTEST>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

