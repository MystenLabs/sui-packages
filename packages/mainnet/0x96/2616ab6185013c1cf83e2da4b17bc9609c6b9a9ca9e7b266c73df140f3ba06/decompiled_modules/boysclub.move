module 0x962616ab6185013c1cf83e2da4b17bc9609c6b9a9ca9e7b266c73df140f3ba06::boysclub {
    struct BOYSCLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOYSCLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOYSCLUB>(arg0, 6, b"BOYSCLUB", b"Boys ClubOn SUI", b"Where memes meet friendship in perfect harmony. Step into the world of Pepe, Andy, Brett, Bird Dog and Landwolf!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_V9k_P3i_R8_Bv6_N_Vgj_Bn_G6_Y_Zbw_Cc9_Juboo_Ge_Tro_Q_Zn_Ti_B_Vr_7e1031e033.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOYSCLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOYSCLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

