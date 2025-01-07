module 0x43dfc5b80280a7046b27a6af667964fbc9faa110e87fdbf145bc7d62317ba424::flip {
    struct FLIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIP>(arg0, 6, b"Flip", b"flipper", b"Who remember Flipper movie.  The dolphin that capture everyone's heart.  Let's bring back flipper to Sui water.                                                  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MV_5_B_Mj_E3_ZTI_2_Y_Tkt_NG_Vh_Mi00_Zj_Vh_L_Tlk_Ym_Qt_M2_Vh_NW_Mw_ZD_Rh_Z_Dc0_Xk_Ey_Xk_Fqc_Gc_V1_17827253a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

