module 0x4c596c50215a6127b27878457a41a6da0497f891f4fb71651403694083c58175::bitcat {
    struct BITCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITCAT>(arg0, 6, b"BITCAT", b"Bitcat", b"Bitcat ...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_QR_19q_Y_Xevk_Uxfin_A36_S_Xn_E_Eh_Rj4p48_ZQ_1_ZW_1jqtr_V_Bfx_37edc7f389.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

