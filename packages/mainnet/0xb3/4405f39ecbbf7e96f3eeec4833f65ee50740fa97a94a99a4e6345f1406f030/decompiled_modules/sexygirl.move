module 0xb34405f39ecbbf7e96f3eeec4833f65ee50740fa97a94a99a4e6345f1406f030::sexygirl {
    struct SEXYGIRL has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SEXYGIRL>, arg1: 0x2::coin::Coin<SEXYGIRL>) {
        0x2::coin::burn<SEXYGIRL>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SEXYGIRL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SEXYGIRL>>(0x2::coin::mint<SEXYGIRL>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SEXYGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEXYGIRL>(arg0, 9, b"Sexygirl", b"SEXYGIRL", b"sexy girl test", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEXYGIRL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEXYGIRL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

