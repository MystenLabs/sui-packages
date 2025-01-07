module 0xa416934b15f851994fd6ed58eaa7eae4e60d2cf2bdb817e30f06107ace5a80f3::toddpham {
    struct TODDPHAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TODDPHAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TODDPHAM>(arg0, 6, b"TODDPHAM", b"ToddPham", b"TODDPHAM alonenight Driver to the mooooooon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ugqz_Zu98_PVDWEH_2_Te_L3wb_S4_Szv33_Cx_Eyicih_KHS_Wn6b_J_ac67536c4d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TODDPHAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TODDPHAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

