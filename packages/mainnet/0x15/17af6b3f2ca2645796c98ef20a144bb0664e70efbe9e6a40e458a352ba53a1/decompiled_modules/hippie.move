module 0x1517af6b3f2ca2645796c98ef20a144bb0664e70efbe9e6a40e458a352ba53a1::hippie {
    struct HIPPIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPIE>(arg0, 6, b"HIPPIE", b"HIPPIE GIRL", b"HIPPIE GIRL HIPPIE GIRL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigoqlc4uvofxo2hz6z2prdb5y6tljs5rc5uaom7yduyuobwk2xb74")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HIPPIE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

