module 0x71a4645a0e45a6902e1158d6b0e8309a0ba5104baaaf1f2daf9b9c8ba8ed0cb7::pola {
    struct POLA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<POLA>, arg1: 0x2::coin::Coin<POLA>) {
        0x2::coin::burn<POLA>(arg0, arg1);
    }

    fun init(arg0: POLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLA>(arg0, 10, b"POL", b"POLA", b"my coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POLA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<POLA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<POLA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

