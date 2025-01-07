module 0x1cb98f35f21e2723593ae52a6bfc9bec4deb248382aa4878874ee2d8069e99fb::fcpd {
    struct FCPD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCPD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCPD>(arg0, 6, b"FCPD", b"FlyingCheesePuffDog", b"FlyingCheesePuffDog on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf6_WL_Ec_LY_Po_Qagmimb_UE_Ap_C1j_Vpp6_P_Qx_D64_X8yiw_Az_JYU_feb357697d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCPD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FCPD>>(v1);
    }

    // decompiled from Move bytecode v6
}

