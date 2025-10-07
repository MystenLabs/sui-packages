module 0x49a0434e8a3e66828587b2d8166aeb23d62b34436204884eb68d1e4b38e1ae47::minimal_token {
    struct MINIMAL_TOKEN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MINIMAL_TOKEN>, arg1: 0x2::coin::Coin<MINIMAL_TOKEN>) {
        0x2::coin::burn<MINIMAL_TOKEN>(arg0, arg1);
    }

    public entry fun destroy_treasury_cap(arg0: 0x2::coin::TreasuryCap<MINIMAL_TOKEN>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINIMAL_TOKEN>>(arg0, @0x0);
    }

    fun init(arg0: MINIMAL_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINIMAL_TOKEN>(arg0, 6, b"MT", b"MinimalToken", b"A minimal test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINIMAL_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINIMAL_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MINIMAL_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MINIMAL_TOKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

