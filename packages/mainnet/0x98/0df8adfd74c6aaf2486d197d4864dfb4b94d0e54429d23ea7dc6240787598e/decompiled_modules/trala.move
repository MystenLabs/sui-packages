module 0x980df8adfd74c6aaf2486d197d4864dfb4b94d0e54429d23ea7dc6240787598e::trala {
    struct TRALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRALA>(arg0, 6, b"TRALA", b"Tralalero Tralala", b"Tralalero Tralala in Sui is a whimsical and playful memecoin concept built on the Sui Blockchain. It combines absurd humor with cathcy, almost musical branding to create instant viral appeal.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiebzygwnattpkkd7lf5etvyrumfeusgngbieip5rrya2n3lzshzla")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRALA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

