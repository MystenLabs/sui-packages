module 0x15ce6c1e0bb83e9cc198b4ee25def25fa3ea2d4a03a5fef4f235060f750f823b::pope {
    struct POPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPE>(arg0, 9, b"POPE", b"Robert Francis Prevost", b"OG Token, the first coin launched on the Solana blockchain in honor of the first American pope, was created on April 25, 2025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/3j11JP4ijPYwN3A22Njj2ssbS4fCWtJteMAaBJNxpump.png?size=xl&key=077319")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POPE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPE>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

