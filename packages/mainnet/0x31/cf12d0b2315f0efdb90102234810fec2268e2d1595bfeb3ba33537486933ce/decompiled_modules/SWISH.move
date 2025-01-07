module 0x31cf12d0b2315f0efdb90102234810fec2268e2d1595bfeb3ba33537486933ce::SWISH {
    struct SWISH has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SWISH>, arg1: 0x2::coin::Coin<SWISH>) {
        0x2::coin::burn<SWISH>(arg0, arg1);
    }

    fun init(arg0: SWISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWISH>(arg0, 9, b"Swish", b"SWISH", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWISH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWISH>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SWISH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SWISH>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

