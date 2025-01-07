module 0x1cf89016a91e11b6a234df6085795aaed11df9520b0d5bef14d14a8581426527::beast {
    struct BEAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAST>(arg0, 6, b"BEAST", b"MR.BEAST", b"MrBeast is now being followed by coinbase once again. Its feeling like 2021 bull run all over  Something is cooking.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_Ec_R_Nr2_G_Qz_Kj_B7_Rp7ug_Btjcf_C_Lj_Nu_Kswj_F_Wn_Zf_Ny_Tx_Ji_8f55a5439a.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

