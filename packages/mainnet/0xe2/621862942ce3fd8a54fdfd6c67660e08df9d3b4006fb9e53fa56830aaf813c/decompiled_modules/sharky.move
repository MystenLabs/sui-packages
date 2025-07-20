module 0xe2621862942ce3fd8a54fdfd6c67660e08df9d3b4006fb9e53fa56830aaf813c::sharky {
    struct SHARKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKY>(arg0, 6, b"SHARKY", b"SHARKY ON SUI", b"This is SHARKY on the SUI tank.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreietwms2j357iadywayc45fhmkabxp6o5xwubqac6ejhdmvbi3auuy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHARKY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

