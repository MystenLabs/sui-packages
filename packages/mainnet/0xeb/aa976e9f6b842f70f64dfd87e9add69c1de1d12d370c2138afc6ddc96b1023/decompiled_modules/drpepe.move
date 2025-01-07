module 0xebaa976e9f6b842f70f64dfd87e9add69c1de1d12d370c2138afc6ddc96b1023::drpepe {
    struct DRPEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DRPEPE>, arg1: 0x2::coin::Coin<DRPEPE>) {
        0x2::coin::burn<DRPEPE>(arg0, arg1);
    }

    fun init(arg0: DRPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRPEPE>(arg0, 2, b"DR Pepe", b"DRPEP", b"Dr.Pepe is here to serve", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DRPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DRPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

