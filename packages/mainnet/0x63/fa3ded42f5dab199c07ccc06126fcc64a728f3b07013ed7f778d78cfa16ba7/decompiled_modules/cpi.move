module 0x63fa3ded42f5dab199c07ccc06126fcc64a728f3b07013ed7f778d78cfa16ba7::cpi {
    struct CPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPI>(arg0, 6, b"CPI", b"Cabal Price Index", b"Cabal Price Index Relaunch!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie746iiqpuuqgi2a74g7qfvjun7ei4ftsvy26gpphggcu3dkuqqam")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CPI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

