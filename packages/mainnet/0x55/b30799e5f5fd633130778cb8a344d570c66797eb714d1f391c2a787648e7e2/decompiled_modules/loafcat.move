module 0x55b30799e5f5fd633130778cb8a344d570c66797eb714d1f391c2a787648e7e2::loafcat {
    struct LOAFCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOAFCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOAFCAT>(arg0, 6, b"LOAFCAT", b"Sui LOAFCAT", x"4c4f41464341543a204361747320686176652074616b656e206f766572207468652042616b657279210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Loafd_J3_WS_Avsrx3zpp_SGKA_6s_Rv_L9_Gr_Rr_U1i_RV_7_Hk_Lkm_56cf528d40.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOAFCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOAFCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

