module 0xc55ca441acf9c541aabd789d0494212acde26c86a0493ed829db2a87e2a3cdd4::blue {
    struct BLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUE>(arg0, 6, b"BLUE", b"Blue Cat", b"Cat CTO for all blue cat lovers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Q_Bbm_Pf_EG_Lhdx4y_LV_Xr36o_Rfz_Z_Nigfbd_T4y_M_Xby_PNQA_1_F_83dde4e9b8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

