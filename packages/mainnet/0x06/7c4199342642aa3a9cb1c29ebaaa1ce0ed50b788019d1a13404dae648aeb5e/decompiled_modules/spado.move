module 0x67c4199342642aa3a9cb1c29ebaaa1ce0ed50b788019d1a13404dae648aeb5e::spado {
    struct SPADO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPADO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPADO>(arg0, 6, b"SPADO", b"SPACEDOG", b"Space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihlfi7p3p57fn4b7vwlmd7rbsxiyeosl4bjuvfwaktjytmlboagtm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPADO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPADO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

