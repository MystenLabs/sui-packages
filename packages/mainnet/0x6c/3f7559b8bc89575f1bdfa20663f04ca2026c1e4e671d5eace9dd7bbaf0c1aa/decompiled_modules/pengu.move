module 0x6c3f7559b8bc89575f1bdfa20663f04ca2026c1e4e671d5eace9dd7bbaf0c1aa::pengu {
    struct PENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGU>(arg0, 9, b"PENGU", b"Pudgy Penguins", x"537072656164696e6720676f6f64207669626573206163726f737320746865206d65746120f09f90a7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/9d24jNVbvHQH3pCB1ZzxRjpFuVV4j1MMJDU3SPxQpump.png?size=xl&key=3b958d")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PENGU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENGU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

