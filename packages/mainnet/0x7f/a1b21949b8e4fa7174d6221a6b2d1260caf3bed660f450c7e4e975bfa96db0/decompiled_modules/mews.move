module 0x7fa1b21949b8e4fa7174d6221a6b2d1260caf3bed660f450c7e4e975bfa96db0::mews {
    struct MEWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEWS>(arg0, 6, b"MEWS", b"SuiTwo", b"Created, not born. The most powerful Pokemon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigpxngdtbvvpl425lvszshzc6et6iwp33fpfjfewq44mh7tqmpol4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEWS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

