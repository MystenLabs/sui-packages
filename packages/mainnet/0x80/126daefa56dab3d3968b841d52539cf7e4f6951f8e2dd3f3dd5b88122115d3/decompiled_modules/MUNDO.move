module 0x80126daefa56dab3d3968b841d52539cf7e4f6951f8e2dd3f3dd5b88122115d3::MUNDO {
    struct MUNDO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MUNDO>, arg1: 0x2::coin::Coin<MUNDO>) {
        0x2::coin::burn<MUNDO>(arg0, arg1);
    }

    fun init(arg0: MUNDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUNDO>(arg0, 9, b"MUNDO", b"MUNDO", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/4fBQ8Tj/mundo.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUNDO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUNDO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MUNDO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MUNDO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

