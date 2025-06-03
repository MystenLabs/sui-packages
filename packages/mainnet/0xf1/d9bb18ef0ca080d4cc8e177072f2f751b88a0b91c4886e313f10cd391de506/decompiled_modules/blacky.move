module 0xf1d9bb18ef0ca080d4cc8e177072f2f751b88a0b91c4886e313f10cd391de506::blacky {
    struct BLACKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKY>(arg0, 6, b"BLACKY", b"The Blacky Cat", b"The only Black cat on sui chain, I don't meoww, I purrr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibg5xpxbm2faosbkqocrtw4ucpuqxxhsykx5xxv43jk2ik6jeqjqe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLACKY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

