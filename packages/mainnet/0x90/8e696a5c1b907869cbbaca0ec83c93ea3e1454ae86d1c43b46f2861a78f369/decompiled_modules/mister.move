module 0x908e696a5c1b907869cbbaca0ec83c93ea3e1454ae86d1c43b46f2861a78f369::mister {
    struct MISTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MISTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MISTER>(arg0, 6, b"MISTER", b"Illuminati", b"Do you have water only?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GX_0m_TR_7_WYA_Et_Bv_G_afe7103fb9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MISTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MISTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

