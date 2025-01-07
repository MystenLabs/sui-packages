module 0xa8c4ef8db6b244b1d3833d793517d9500837afe8e1065d540f8cdf0b864caaf2::bitsui {
    struct BITSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BITSUI>, arg1: 0x2::coin::Coin<BITSUI>) {
        0x2::coin::burn<BITSUI>(arg0, arg1);
    }

    fun init(arg0: BITSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITSUI>(arg0, 9, b"BITSUI", b"Bit Sui", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BITSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BITSUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

