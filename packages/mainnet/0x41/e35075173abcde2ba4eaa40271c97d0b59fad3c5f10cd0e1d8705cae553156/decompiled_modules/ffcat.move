module 0x41e35075173abcde2ba4eaa40271c97d0b59fad3c5f10cd0e1d8705cae553156::ffcat {
    struct FFCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFCAT>(arg0, 6, b"FFCAT", b"TO FAST TO FURIOUS CAT", b"TO FAST TO FURIOUS CAT.....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme2c_Fv_H_Gx_B_Du_T8wag9f_P_Tvk9_Hqne_T6_M_Pp_Jb_Z4dvxr_Db2d_d0363be74f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FFCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

