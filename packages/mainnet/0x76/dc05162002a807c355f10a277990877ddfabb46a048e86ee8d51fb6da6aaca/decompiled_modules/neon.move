module 0x76dc05162002a807c355f10a277990877ddfabb46a048e86ee8d51fb6da6aaca::neon {
    struct NEON has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEON>(arg0, 9, b"NEON", b"Neon The One", b"Exit the matrix", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0xfd88302bc6053a59a6548082230f6f6f3ea7b2b1.png?size=lg&key=cc8458")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEON>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEON>>(v1);
    }

    // decompiled from Move bytecode v6
}

