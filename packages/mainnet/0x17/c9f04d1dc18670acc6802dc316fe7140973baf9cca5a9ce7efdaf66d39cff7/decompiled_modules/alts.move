module 0x17c9f04d1dc18670acc6802dc316fe7140973baf9cca5a9ce7efdaf66d39cff7::alts {
    struct ALTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALTS>(arg0, 9, b"ALTS", b"ALTS", b"Twitter: https://x.com/EricTrump/status/1954881801551548839", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://38.240.51.36:3012/image/d1222654-cfa8-401b-a2f4-81ad3667f108.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ALTS>(&mut v2, 1000000000000000000, @0xb0ed1ff98508d0cd74fb515e595ae0879b652d21a6a93eb94a8e707bde83f73b, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALTS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

