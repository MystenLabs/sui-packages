module 0xf7c1a291f050b727024ab5dfffe09767c2fab5ee99bdd48f2d3debe93640b916::nan {
    struct NAN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<NAN>, arg1: 0x2::coin::Coin<NAN>) {
        0x2::coin::burn<NAN>(arg0, arg1);
    }

    fun init(arg0: NAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAN>(arg0, 2, b"NAN", b"NaN Coin", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NAN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NAN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

