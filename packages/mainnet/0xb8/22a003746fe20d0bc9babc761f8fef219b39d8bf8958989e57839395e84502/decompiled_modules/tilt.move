module 0xb822a003746fe20d0bc9babc761f8fef219b39d8bf8958989e57839395e84502::tilt {
    struct TILT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TILT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TILT>(arg0, 6, b"TILT", b"Tiltao", b"sitting tiger", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Qn_Pj17ak_AM_Dil_F_33486578ed.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TILT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TILT>>(v1);
    }

    // decompiled from Move bytecode v6
}

