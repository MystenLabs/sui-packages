module 0x29e4db3c238d68942cf9d97bab2c10a3910d787b520b01db08dc4f20973320d0::pcat {
    struct PCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCAT>(arg0, 6, b"PCAT", b"Pixel Cat", b"Pixel concept MEME, we are a CTO team", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/a_ae_a_c_20240925023727_e2b3d81d40.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

