module 0x82ac1327de1f266b862043b9921b3fd352b692c9800457d2b9090f5464645e69::maga {
    struct MAGA has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 8, b"MAKE AMERICA GREAT AGAIN", b"MAGA", b"MAGA is a token with a mission to empower and inspire.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/maga-icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: MAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<MAGA>(arg0, arg1);
        0x2::coin::mint_and_transfer<MAGA>(&mut v0, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MAGA>>(v0);
    }

    // decompiled from Move bytecode v6
}

