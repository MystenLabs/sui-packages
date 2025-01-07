module 0x910bc2a0a4ab39ce0f43d1e87e3245494eaaa0d97cdcd5202ff2928c339ca402::nigi {
    struct NIGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGI>(arg0, 6, b"NIGI", b"Nigi Cat", b"The cat is black", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3bo_RK_Ax_WR_6we_V6kufr9ykd_Lcm9c_L5q2p469t_Cqe_C_An_Hy_157eac13e5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

