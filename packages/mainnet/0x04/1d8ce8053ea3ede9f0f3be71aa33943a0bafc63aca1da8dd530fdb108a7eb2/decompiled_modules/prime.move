module 0x41d8ce8053ea3ede9f0f3be71aa33943a0bafc63aca1da8dd530fdb108a7eb2::prime {
    struct PRIME has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PRIME>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PRIME>>(0x2::coin::mint<PRIME>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PRIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIME>(arg0, 6, b"PRIME", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRIME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRIME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

