module 0xf226a2930045bdd122ab5f9402bbdd95dcd6b528ba9daf05b548432f5f7b39ef::exts {
    struct EXTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXTS>(arg0, 6, b"EXTS", b"Elon X Trump", b"Elon X Trump Saga EXTS on SUI captures the 2025 feud between Elon musk and Donald Trump.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieoitvu7kvtdzcghqogntahpzw72ph72nmkmkwwkd2lx52biosiqa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EXTS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

