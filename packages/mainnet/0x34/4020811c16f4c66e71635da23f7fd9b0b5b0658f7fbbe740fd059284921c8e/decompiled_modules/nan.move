module 0x344020811c16f4c66e71635da23f7fd9b0b5b0658f7fbbe740fd059284921c8e::nan {
    struct NAN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<NAN>, arg1: 0x2::coin::Coin<NAN>) {
        0x2::coin::burn<NAN>(arg0, arg1);
    }

    fun init(arg0: NAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAN>(arg0, 2, b"NAN", b"MNG", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NAN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NAN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

