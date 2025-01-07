module 0xffdee15953a6c2a6fbedccc53b5fea8fe8219b7caabd1b35332ff6549ea8008d::skull {
    struct SKULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKULL>(arg0, 6, b"SKULL", b"Skull", x"4920616d206120534b554c4c210a4265666f726520796f752073656e642c20666972737420746f206a6f696e2054472c20206d617962652077652063616e2070756d703f210a742e6d652f534b554c4c5f4d4f564550554d50", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_L_Mgps_Dgajcs8v_M_Qkn_Vu9_F_Hu_E_Hc_Vn_Wu_P3evz_E3qkk_L_Nt_8df98e3f38.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

