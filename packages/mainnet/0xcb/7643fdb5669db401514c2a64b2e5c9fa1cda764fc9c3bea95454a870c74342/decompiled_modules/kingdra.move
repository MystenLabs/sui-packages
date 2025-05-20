module 0xcb7643fdb5669db401514c2a64b2e5c9fa1cda764fc9c3bea95454a870c74342::kingdra {
    struct KINGDRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGDRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGDRA>(arg0, 6, b"KINGDRA", b"KINGDRA SUI", b"KINGDRA WAS DETERMINED TO APPLY WHAT HE HAD LEARNED. HE WORKED TIRELESSLY, LEVERAGING HIS NEWFOUND KNOWLEDGE TO CREATE A UNIQUE MEMECOIN. THIS TOKEN ISN'T JUST A DIGITAL ASSET; IT'S A SYMBOL OF $KINGDRA INCREDIBLE JOURNEY AND THE INSIGHTS HE GAINED", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicfbwio7ttjhs3hm6n2viys4zmxyp6coebb3imknvaegkn4mtdjb4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGDRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KINGDRA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

