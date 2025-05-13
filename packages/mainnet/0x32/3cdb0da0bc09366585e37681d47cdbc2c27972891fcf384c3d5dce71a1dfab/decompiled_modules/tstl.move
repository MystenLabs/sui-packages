module 0x323cdb0da0bc09366585e37681d47cdbc2c27972891fcf384c3d5dce71a1dfab::tstl {
    struct TSTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSTL>(arg0, 6, b"TSTL", b"Testing again", b"testing something", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigafodl7ux6fulvr2cbqtuqoof5gjwnffb7svub5indu36iaxnjoy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TSTL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

