module 0x534984f4bee945622a5329fab2d6b5d8a4960bae68f5478f3659fcd81d06720d::prick {
    struct PRICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRICK>(arg0, 6, b"PRICK", b"Pickle Rick", x"546865206d6f737420706f70756c6172206d656d6520696e2074686520776f726c642c205069636b6c65205269636b206f6e205375690a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6zoshtkmy_X4k_R_Fg3p152y_V2b_Pssxe_Yd_Nv_W3c6_EVCE_4_UP_768ec712ba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

