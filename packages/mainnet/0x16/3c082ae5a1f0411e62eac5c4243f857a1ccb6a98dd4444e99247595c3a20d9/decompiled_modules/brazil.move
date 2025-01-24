module 0x163c082ae5a1f0411e62eac5c4243f857a1ccb6a98dd4444e99247595c3a20d9::brazil {
    struct BRAZIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAZIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAZIL>(arg0, 9, b"BRAZIL", b"Brazil Official", b"$BRAZIL  A Moeda Oficial do Orgulho Brasileiro ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSewWoVHoN5gjH5qKtYJn62HpCqogic1uWFgjhQdVpjtd")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BRAZIL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRAZIL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAZIL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

