module 0x2772bf051f6a15f4013fe496acfee362a4d7ab81c62c1bc9f99df4ef1164ec14::ypiii {
    struct YPIII has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<YPIII>, arg1: 0x2::coin::Coin<YPIII>) {
        0x2::coin::burn<YPIII>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YPIII>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<YPIII>>(0x2::coin::mint<YPIII>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: YPIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YPIII>(arg0, 9, b"ypiii", b"YPIII", b"hello yapiii", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YPIII>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YPIII>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

