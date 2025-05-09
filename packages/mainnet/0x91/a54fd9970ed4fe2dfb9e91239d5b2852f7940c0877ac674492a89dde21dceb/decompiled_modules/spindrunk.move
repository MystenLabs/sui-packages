module 0x91a54fd9970ed4fe2dfb9e91239d5b2852f7940c0877ac674492a89dde21dceb::spindrunk {
    struct SPINDRUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPINDRUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPINDRUNK>(arg0, 6, b"SpinDrunk", b"Spin On SUI", b"Spinda stan  | Drunk on Sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibgbslx74vwr4b3wmgwckwxim3ygulutnxwhgnsjzmvfvc4pshlom")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPINDRUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPINDRUNK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

