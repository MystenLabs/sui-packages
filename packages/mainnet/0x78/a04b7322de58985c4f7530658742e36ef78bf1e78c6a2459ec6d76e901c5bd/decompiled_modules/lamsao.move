module 0x78a04b7322de58985c4f7530658742e36ef78bf1e78c6a2459ec6d76e901c5bd::lamsao {
    struct LAMSAO has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LAMSAO>, arg1: 0x2::coin::Coin<LAMSAO>) {
        0x2::coin::burn<LAMSAO>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LAMSAO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LAMSAO>>(0x2::coin::mint<LAMSAO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LAMSAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMSAO>(arg0, 6, b"LAMSAO", b"LAMSAO CON CAC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAMSAO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMSAO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

