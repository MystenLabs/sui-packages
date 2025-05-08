module 0x37dca9c58114d4500771dc7e6df564dcedb57be3a8fdf02a310b31c0e1a9aa86::sanml {
    struct SANML has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANML>(arg0, 6, b"SANML", b"SuiAnimals", b"meoww", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiedfqa6f2kmue5l5r537qsquhjr42ptbiqjstbvqfnflv7vtcj6ra")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANML>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SANML>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

