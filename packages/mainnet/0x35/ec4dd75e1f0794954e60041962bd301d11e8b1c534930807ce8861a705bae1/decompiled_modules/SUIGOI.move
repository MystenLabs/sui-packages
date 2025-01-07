module 0x35ec4dd75e1f0794954e60041962bd301d11e8b1c534930807ce8861a705bae1::SUIGOI {
    struct SUIGOI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIGOI>, arg1: 0x2::coin::Coin<SUIGOI>) {
        0x2::coin::burn<SUIGOI>(arg0, arg1);
    }

    fun init(arg0: SUIGOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGOI>(arg0, 2, b"SUIGOI", b"SUIGOI", b"lets suigoi", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIGOI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIGOI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIGOI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

