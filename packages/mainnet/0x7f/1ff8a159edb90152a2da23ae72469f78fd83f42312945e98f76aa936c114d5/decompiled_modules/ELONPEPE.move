module 0x7f1ff8a159edb90152a2da23ae72469f78fd83f42312945e98f76aa936c114d5::ELONPEPE {
    struct ELONPEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ELONPEPE>, arg1: 0x2::coin::Coin<ELONPEPE>) {
        0x2::coin::burn<ELONPEPE>(arg0, arg1);
    }

    fun init(arg0: ELONPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONPEPE>(arg0, 6, b"ELPEPE", b"ELON PEPE", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/XF3dtJX/Mf5-GXU-1-400x400.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELONPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ELONPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ELONPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

