module 0x99780f2828706064a2bd2de4c3eb9d36a2266c8551e388bfed0abf02234be163::grog {
    struct GROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROG>(arg0, 6, b"GROG", b"Space Grog", b"grog lives on uranus.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Q_Sggsnfm8u_Gbh_C55ff_M9nei_Chxe_Cg_Vap2ar6_XZRR_Hx2_D_111bfe63f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

