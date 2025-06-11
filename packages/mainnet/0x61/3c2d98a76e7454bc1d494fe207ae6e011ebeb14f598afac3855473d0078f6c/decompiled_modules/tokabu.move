module 0x613c2d98a76e7454bc1d494fe207ae6e011ebeb14f598afac3855473d0078f6c::tokabu {
    struct TOKABU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKABU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKABU>(arg0, 6, b"TOKABU", b"TOKABUSUI", b"I'm $TOKABU, the spirit of gambling", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic3sirwzmch7e4tkjw3nfu2oxyjtq4njg3ezevfiype2iep3gheve")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKABU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKABU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

