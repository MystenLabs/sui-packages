module 0x3ee9c1bb19fd35de16cae83811c9d86c24011dfa26e79997893ab1f90d1a01fb::sqdsq {
    struct SQDSQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQDSQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQDSQ>(arg0, 6, b"SQDSQ", b"dssq", b"DSDQFDFQS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihybyjfjlh74w7gxjyejdss5la5tgko74tn457msxyqekizoa5unq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQDSQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SQDSQ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

