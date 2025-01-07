module 0x3081da6690b10d0be8937b58bf603ec3bd4d018e4c9da6a3fa0fee4de65a6077::lgcoin_two {
    struct LGCOIN_TWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LGCOIN_TWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LGCOIN_TWO>(arg0, 9, b"LGCOIN", b"Lugon Token", b"Testing purpose", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LGCOIN_TWO>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LGCOIN_TWO>>(v0);
    }

    public entry fun mint_coin(arg0: &mut 0x2::coin::TreasuryCap<LGCOIN_TWO>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LGCOIN_TWO>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

