module 0xd22492ac7935a75cf82b0db97943c0cd9578641f9cb21f77671f6b83e3626c1d::pdpk {
    struct PDPK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDPK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDPK>(arg0, 6, b"PDPK", b"Pudgy Payback", x"5765726520796f752076696374696d73206f66207468652070656e67752064726f703f2054696d6520746f206d616b6520796f75722062616773206261636b2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Nu_X2xx2nc6_G_Vwrz_CRL_Jy_Zgnhr5_V84j_C4_ENL_19_WW_Mcyij_a306c06244.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDPK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PDPK>>(v1);
    }

    // decompiled from Move bytecode v6
}

