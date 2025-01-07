module 0x255b665039857de0ec1010801483b5d38706b53c07bce1c3f51753b9c9698221::psp {
    struct PSP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSP>(arg0, 6, b"PSP", b"Purple Santa Pepe", x"466972737420507572706c652053616e74612050657065206f6e205375692054686520467574757265206f662050657065200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Xv_N8jq_Leogt_X_Kq_Hi_E1ro_Yr_NDYU_Top1_Vmh_QFA_5jf_Sq_J1_A_3720b891d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSP>>(v1);
    }

    // decompiled from Move bytecode v6
}

