module 0x13e74108e0ca5d419a5c335630c5680e875b21e327a8d45236b947759bf12e17::puffy {
    struct PUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFY>(arg0, 8, b"PUFFY", b"Puffy", b"end", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/D9paufRCehpk2YGRPkzJPEUDsvQjaTFKNyFDqgd4xqd.png?size=lg&key=58ee43")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUFFY>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

