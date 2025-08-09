module 0x2cd5fc579735621366d574f4bea220a4d0b0ad323d69b5d2f23966d9011e67c8::penbu {
    struct PENBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENBU>(arg0, 6, b"PENBU", b"Pengububu", b"Welcome aboard Pengububu Airlines. Fasten seat belts; your journey will begin shortly.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreica3brm3jip56klldclu4rbwyytoyhks6ey7vavkiobw3qv5ryrjm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PENBU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

