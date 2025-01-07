module 0xe75dbb926e1f213309f9e71068f4c7f0b4166f6c1b3577c25e2fa23bd4659198::drpepe {
    struct DRPEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DRPEPE>, arg1: 0x2::coin::Coin<DRPEPE>) {
        0x2::coin::burn<DRPEPE>(arg0, arg1);
    }

    fun init(arg0: DRPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRPEPE>(arg0, 2, b"MANAGED", b"MNG", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DRPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DRPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

