module 0x450b903fcbeccdac018bfddd6ba0ac0e60db21466320281dc41f9ff67c4ab019::guac {
    struct GUAC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GUAC>, arg1: 0x2::coin::Coin<GUAC>) {
        0x2::coin::burn<GUAC>(arg0, arg1);
    }

    fun init(arg0: GUAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUAC>(arg0, 6, b"GUAC", b"Guacamole", b"The best ingredients to keep your crypto portfolio super fresh.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.guacamole.gg/_next/image?url=%2Fimages%2Flogo.png&w=48&q=75")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUAC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUAC>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GUAC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GUAC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

