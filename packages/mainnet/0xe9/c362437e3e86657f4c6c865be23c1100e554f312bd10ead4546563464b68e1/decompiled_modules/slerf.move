module 0xe9c362437e3e86657f4c6c865be23c1100e554f312bd10ead4546563464b68e1::slerf {
    struct SLERF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLERF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLERF>(arg0, 6, b"Slerf", b"Slerff", b"Slerf new meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5518_b21d822a47.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLERF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLERF>>(v1);
    }

    // decompiled from Move bytecode v6
}

