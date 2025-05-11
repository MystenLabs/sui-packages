module 0x179b8ebfb402f772b100c6076f671b37cb94c6cea3bf785481f88f79f3c480b0::pookie {
    struct POOKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOKIE>(arg0, 9, b"POOKIE", b"Pookiecoin", b"Pookie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/FKHxF5xc1q6EsE1t3Dj1AMNVUUCYFWgyXNUXphDZpump.png?size=xl&key=8f9dee")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POOKIE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOKIE>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POOKIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

