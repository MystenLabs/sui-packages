module 0xc1708c9e7fec807ebd87e2c8d9d9f2faf5340cc92d34d2fc913f3550738a1b1b::bambiii {
    struct BAMBIII has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BAMBIII>, arg1: 0x2::coin::Coin<BAMBIII>) {
        0x2::coin::burn<BAMBIII>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BAMBIII>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BAMBIII>>(0x2::coin::mint<BAMBIII>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BAMBIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAMBIII>(arg0, 9, b"Bambiii", b"BAMBIII", b"bambiiiii", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAMBIII>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAMBIII>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

