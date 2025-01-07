module 0x11419d2c8f3b8a348e4ad9ad1032e41cdd21a506deb07eb78cec7a794e0e49b1::popluceg {
    struct POPLUCEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPLUCEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPLUCEG>(arg0, 6, b"POPLUCEG", b"Goatseus Poppimus Luce", x"43727970746f20697320746865204368757263682c20476f6174204c7563652069732074686520506f7065204c697374656e2c206275792024504f504c5543454720616e6420796f75722077616c6c657473207368616c6c20666c79210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_RAJ_4ogw_Tq_Ews4_Nbak_Mb_L3jukp_Gknvi_QWCR_2a_Tde_Hqhq_Z_f6de24fef7.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPLUCEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPLUCEG>>(v1);
    }

    // decompiled from Move bytecode v6
}

