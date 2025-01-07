module 0x3bad406cdf9cfaaf5d1d4c1fc94b9e80ce45897b05cbea864764c02ffcd48d1::ZUKASUI {
    struct ZUKASUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZUKASUI>, arg1: 0x2::coin::Coin<ZUKASUI>) {
        0x2::coin::burn<ZUKASUI>(arg0, arg1);
    }

    fun init(arg0: ZUKASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUKASUI>(arg0, 9, b"ZUKA", b"ZUKA SUI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZUKASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUKASUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZUKASUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZUKASUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

