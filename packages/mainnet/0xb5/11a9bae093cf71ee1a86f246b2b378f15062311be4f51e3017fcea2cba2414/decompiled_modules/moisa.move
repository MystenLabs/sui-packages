module 0xb511a9bae093cf71ee1a86f246b2b378f15062311be4f51e3017fcea2cba2414::moisa {
    struct MOISA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MOISA>, arg1: 0x2::coin::Coin<MOISA>) {
        0x2::coin::burn<MOISA>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOISA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOISA>>(0x2::coin::mint<MOISA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOISA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOISA>(arg0, 9, b"moisa", b"MOISA", b"test token checking now", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOISA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOISA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

