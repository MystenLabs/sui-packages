module 0x343d20e8b9c591fe543e8f3f391e3c30b97b5e6d5e86e86eea5ad5d9f553c7a9::astro {
    struct ASTRO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ASTRO>, arg1: 0x2::coin::Coin<ASTRO>) {
        0x2::coin::burn<ASTRO>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ASTRO>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ASTRO> {
        0x2::coin::mint<ASTRO>(arg0, arg1, arg2)
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<ASTRO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ASTRO>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: ASTRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASTRO>(arg0, 0, b"ASTRO", b"ASTRO", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASTRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASTRO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

