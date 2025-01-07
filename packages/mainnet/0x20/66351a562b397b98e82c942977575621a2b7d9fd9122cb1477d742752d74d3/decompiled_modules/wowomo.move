module 0x2066351a562b397b98e82c942977575621a2b7d9fd9122cb1477d742752d74d3::wowomo {
    struct WOWOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOWOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOWOMO>(arg0, 6, b"WOWOMO", b"wowomo sui", b"$wowomo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_Qrm_Nq_M8_Gs_Dx_GCK_Dnq_S_Fnxe4c_MD_1_Zo_YA_Bt_Kd_NB_5_Z4_Hyh_0050a67b6f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOWOMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOWOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

