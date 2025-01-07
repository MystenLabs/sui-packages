module 0x9a289f88fb155fc1c4db82f99fa52bcc20d25bdea4ef3d57e25fe72ed697ac6c::degenpad {
    struct DEGENPAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGENPAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGENPAD>(arg0, 6, b"DEGENPAD", b"Degenpad", b"All-in-one Platform to manage your trench team. DEGENPAD like never before with DEGENPAD-team AI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_Jg_TGG_8f_Pww_Tzfq_E_Bi_G6n1azfa_Yv_E_Lch_Jhj_Yk_BBAWR_3y_36a7a3cb17.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGENPAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEGENPAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

