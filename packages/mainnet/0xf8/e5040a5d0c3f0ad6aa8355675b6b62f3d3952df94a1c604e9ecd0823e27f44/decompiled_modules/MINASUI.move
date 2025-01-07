module 0xf8e5040a5d0c3f0ad6aa8355675b6b62f3d3952df94a1c604e9ecd0823e27f44::MINASUI {
    struct MINASUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MINASUI>, arg1: 0x2::coin::Coin<MINASUI>) {
        0x2::coin::burn<MINASUI>(arg0, arg1);
    }

    fun init(arg0: MINASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINASUI>(arg0, 9, b"MINASUI", b"MINASUI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINASUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MINASUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MINASUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

