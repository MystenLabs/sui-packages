module 0x84e14cb6c39e77e8e799c316839f27e415587aaa3a33747219435eb964145c36::ultrasui {
    struct ULTRASUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ULTRASUI>, arg1: 0x2::coin::Coin<ULTRASUI>) {
        0x2::coin::burn<ULTRASUI>(arg0, arg1);
    }

    fun init(arg0: ULTRASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ULTRASUI>(arg0, 6, b"Ultra SUi", b"ULTRASUI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ULTRASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ULTRASUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ULTRASUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ULTRASUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

