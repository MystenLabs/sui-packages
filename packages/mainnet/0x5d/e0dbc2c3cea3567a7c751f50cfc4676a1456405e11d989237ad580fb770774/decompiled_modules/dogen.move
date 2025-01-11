module 0x5de0dbc2c3cea3567a7c751f50cfc4676a1456405e11d989237ad580fb770774::dogen {
    struct DOGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEN>(arg0, 6, b"DOGEN", b"Dogen crypto", x"4d656d65636f696e206f6e205375692e0a0a546865206f6e6520616e64206f6e6c7920616c70686120646567656e20776974682061207374726f6e6720616972206f66206d617363756c696e69747920616e6420696e6576697461626c6520737563636573732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736619820584.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

