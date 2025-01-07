module 0x32b640e62dbe4c07424bbb347a719275298908d7d1c057e8f8e5f38d604c59f5::PIZZASUI {
    struct PIZZASUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PIZZASUI>, arg1: 0x2::coin::Coin<PIZZASUI>) {
        0x2::coin::burn<PIZZASUI>(arg0, arg1);
    }

    fun init(arg0: PIZZASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIZZASUI>(arg0, 2, b"PIZZASUI", b"PIZZASUI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIZZASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIZZASUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PIZZASUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PIZZASUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

