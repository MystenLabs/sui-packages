module 0xcb1b7e8497fde4a9f7cd39228d95a0ceaf8f52c38b54d9ff6399a5a3e0536736::omega {
    struct OMEGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMEGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMEGA>(arg0, 6, b"OMEGA", b"omega", x"746865206c6173742063686170746572202e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_VTQWH_Yehqmy_Gu92_Kz4qvkd_U_Ntwi_C4_T_Me_Xm1_Z_Eui_L8_JZY_3798a31ad8.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMEGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OMEGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

