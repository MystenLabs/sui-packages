module 0xbfc4355c8346a09703679f615e98a0ecd0bc8879b2301b505bcb0aa88f189878::chuwa {
    struct CHUWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUWA>(arg0, 6, b"Chuwa", b"CHUWA", x"4649525320434855574120444f47204f4e205355490a4e4f205447204e4f2058204a5553542043544f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Yqa88_WX_Kwx_XQCH_Zoqw_FTB_Kt_Y_Vyxdyow_Er_X4_Bp_RMRA_Sv_M_bfa1de0e4f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

