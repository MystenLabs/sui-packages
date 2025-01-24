module 0xb9df7ce48e14dc57b8ad4f8bf3fcc7fd4f0b4dcb187f75183596688130644cbc::trmp {
    struct TRMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRMP>(arg0, 6, b"Trmp", b"Tremp", b"Donald Tremp on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HE_2_W6a_G_Gcq_Vj1_Fn3y_K_Jghk_J_Rs5_Q_Qy8hb_T_Hp6ozkgpump_c4d16a1d03.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

