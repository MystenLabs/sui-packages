module 0xe6ec3e853e3eba6e798d832bfaa1ca42828bb44b897f19c7f5ed294ef8c4e917::coni {
    struct CONI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONI>(arg0, 6, b"CONI", b"coni coin", b"coni the cute conifer cone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_B5w_Vm4x_R_Gh_Wto_C2pp4_ZF_3_Dw_Ck8_T_Hncn_W_Pyb_ELC_En2zi_81b5f4e2d6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CONI>>(v1);
    }

    // decompiled from Move bytecode v6
}

