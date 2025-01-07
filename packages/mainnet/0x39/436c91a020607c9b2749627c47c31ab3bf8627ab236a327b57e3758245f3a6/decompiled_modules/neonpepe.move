module 0x39436c91a020607c9b2749627c47c31ab3bf8627ab236a327b57e3758245f3a6::neonpepe {
    struct NEONPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEONPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEONPEPE>(arg0, 9, b"NEONPEPE", b"Neo Pepe", b"Escape the Matrix", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmXD4yyPnU5Wg4tVmhTcuwTgpNR8Jvs4q4y8U7xBKjUiLi?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEONPEPE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEONPEPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEONPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

