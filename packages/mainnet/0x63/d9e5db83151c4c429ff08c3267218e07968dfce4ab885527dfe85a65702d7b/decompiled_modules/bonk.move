module 0x63d9e5db83151c4c429ff08c3267218e07968dfce4ab885527dfe85a65702d7b::bonk {
    struct BONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONK>(arg0, 6, b"BONK", b"Bonkey", b"Bonkey the Sui monkey!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigez3abcao3jjovdwsjerepoap743jtniykvfbah5jdquqbdtoywi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BONK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

