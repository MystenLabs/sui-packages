module 0x3543b8cf01e15cd0b4c0f4279e0f8c1618f3402c973d89c16988448385d7d697::dric {
    struct DRIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRIC>(arg0, 6, b"DRIC", b"dric cto", b"dricstudio", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Lad_T1okb_E25n_E_O_Wtx_Li_my_TM_9q_TU_Bo_Pjijuksmn_U_569b7ecc79.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

