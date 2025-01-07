module 0x184401d537494988f0e2282e2fc1ed0cb025ac99f4c3525035d0e4d2761a3ae5::ronnie {
    struct RONNIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONNIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONNIE>(arg0, 6, b"RONNIE", b"RONNIE ON SUI", b"Ronnie & Reggiebrothers, gangster princes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ny03ra_LX_400x400_854769e3d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONNIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RONNIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

