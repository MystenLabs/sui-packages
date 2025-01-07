module 0x85f5cb741f514b5f87466403e902eac07d2bae7711d8f1b4ad79825a2013bc29::bull {
    struct BULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULL>(arg0, 6, b"BULL", b"Bull Maximus", b"The green symbol of crypto market where cash never snoozes!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_XNQ_7c1_VJ_9m_Sn3_Naasaa_Y5_F_Di_YN_78_R5p_D9_Taaj_PT_Fuux_E_87cf83e1b0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

