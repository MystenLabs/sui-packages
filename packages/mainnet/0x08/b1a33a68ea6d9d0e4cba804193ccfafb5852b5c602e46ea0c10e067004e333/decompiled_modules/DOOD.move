module 0x8b1a33a68ea6d9d0e4cba804193ccfafb5852b5c602e46ea0c10e067004e333::DOOD {
    struct DOOD has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"DOOD", b"DOOD", b"THE REVOLUTION HAS BEGUN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/5Uare15D5AExZbC9DvQ9NbaMxRbKBeuNhnKCudPKBMjx.png?size=xl&key=be9c9c")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: DOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<DOOD>(arg0, arg1);
        0x2::coin::mint_and_transfer<DOOD>(&mut v0, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

