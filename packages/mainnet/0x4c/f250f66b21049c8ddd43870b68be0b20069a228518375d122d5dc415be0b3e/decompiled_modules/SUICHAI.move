module 0x4cf250f66b21049c8ddd43870b68be0b20069a228518375d122d5dc415be0b3e::SUICHAI {
    struct SUICHAI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUICHAI>, arg1: 0x2::coin::Coin<SUICHAI>) {
        0x2::coin::burn<SUICHAI>(arg0, arg1);
    }

    fun init(arg0: SUICHAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHAI>(arg0, 9, b"SUICHAI", b"SUICHAI", b"SUICHAI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICHAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUICHAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUICHAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

