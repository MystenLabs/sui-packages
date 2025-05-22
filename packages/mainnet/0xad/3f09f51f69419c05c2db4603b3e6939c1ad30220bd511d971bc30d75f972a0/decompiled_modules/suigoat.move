module 0xad3f09f51f69419c05c2db4603b3e6939c1ad30220bd511d971bc30d75f972a0::suigoat {
    struct SUIGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGOAT>(arg0, 6, b"SuiGoat", b"Sui Goat", b"SGOAT embodies a rebellious spirit, bold style, and rap battles on the Sui blockchain. Join SGOAT in shaking up the  market with unmatched swagger and pure style!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiggjn77vdek7w2iwg72w3b73r4kazo4vcefwbronfxbbiq23mix54")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIGOAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

