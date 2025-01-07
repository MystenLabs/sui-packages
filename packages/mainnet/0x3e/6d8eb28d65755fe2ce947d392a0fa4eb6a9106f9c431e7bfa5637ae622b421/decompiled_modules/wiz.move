module 0x3e6d8eb28d65755fe2ce947d392a0fa4eb6a9106f9c431e7bfa5637ae622b421::wiz {
    struct WIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIZ>(arg0, 6, b"WIZ", b"wizardry", b"See the future unfold ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Vwb_X_Abmd_AZ_Za_E_Hv_P3_KUU_47_TU_8_Rb5gxdwam88thx_Hc_E_Cx_c7cabc90e9.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

