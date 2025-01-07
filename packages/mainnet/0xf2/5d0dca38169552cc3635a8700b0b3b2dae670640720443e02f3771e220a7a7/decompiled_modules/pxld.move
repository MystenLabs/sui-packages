module 0xf25d0dca38169552cc3635a8700b0b3b2dae670640720443e02f3771e220a7a7::pxld {
    struct PXLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PXLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PXLD>(arg0, 6, b"PXLD", b"PIXELID", x"556c74696d61746520666967687420636c756220696e2041726361646520556e697665727365210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Qwc_CTA_2_BYS_6u_Qi_Lpmk_ZD_3_Txrdxx_Dxva2zw_V_Nn5_E_Vdgrp_6e1cf4b795.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PXLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PXLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

