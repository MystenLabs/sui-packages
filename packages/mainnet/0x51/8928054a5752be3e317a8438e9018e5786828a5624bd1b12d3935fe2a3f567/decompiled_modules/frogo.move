module 0x518928054a5752be3e317a8438e9018e5786828a5624bd1b12d3935fe2a3f567::frogo {
    struct FROGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGO>(arg0, 6, b"FROGO", b"Frogo", b"Frogo captures the playful and quirky side of the crypto world, representing creativity, humor, and endless possibilities in digital finance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_S8i_Jc_Bk_Psqm_FFF_De_Rc_V9_L6_U6r_X_Kia_Vz_Dccj_Qx_Aurra_S6_f65ccea89d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

