module 0x94f0406d11e0a0e635c80df5cab2568a5bed8a7deaff9de4a4ddeea3909a07d4::blue {
    struct BLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUE>(arg0, 6, b"BLUE", b"Blue Cat", x"746865206361742773206e616d6520697320626c75652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd5ce_Za_H_Avw_Nr_Et98o_W_Dn_VT_8d5_Xt_Dpou_Wg_A_Yer8_Au_PDXE_473b507a4e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

