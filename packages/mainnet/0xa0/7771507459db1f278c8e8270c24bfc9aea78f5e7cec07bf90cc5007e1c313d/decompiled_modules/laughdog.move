module 0xa07771507459db1f278c8e8270c24bfc9aea78f5e7cec07bf90cc5007e1c313d::laughdog {
    struct LAUGHDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUGHDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAUGHDOG>(arg0, 6, b"LaughDog", b"The 1st video game dog", b"Taking this dog past Level 99", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_J7ufxr_Ur_Sbn_Aewrn_FG_Zoph_Pe_Mv5_K4x_Yj_Erx_T6sr72_Dj_fd64965dd8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAUGHDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAUGHDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

