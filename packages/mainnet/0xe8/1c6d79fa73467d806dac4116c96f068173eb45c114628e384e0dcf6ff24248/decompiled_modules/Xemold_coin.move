module 0xe81c6d79fa73467d806dac4116c96f068173eb45c114628e384e0dcf6ff24248::Xemold_coin {
    struct XEMOLD_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<XEMOLD_COIN>, arg1: 0x2::coin::Coin<XEMOLD_COIN>) {
        0x2::coin::burn<XEMOLD_COIN>(arg0, arg1);
    }

    fun init(arg0: XEMOLD_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XEMOLD_COIN>(arg0, 2, b"Xemold_COIN", b"hhh", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XEMOLD_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XEMOLD_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<XEMOLD_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<XEMOLD_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

