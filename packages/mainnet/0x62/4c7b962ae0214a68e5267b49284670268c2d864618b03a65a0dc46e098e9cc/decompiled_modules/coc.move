module 0x624c7b962ae0214a68e5267b49284670268c2d864618b03a65a0dc46e098e9cc::coc {
    struct COC has drop {
        dummy_field: bool,
    }

    fun init(arg0: COC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COC>(arg0, 6, b"COC", b"Creation of Cat", b"Creation of Cat's ready for the adventure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_U_Wqh7cje_Y3_Bmh_K_Jwd_Y9u_Zs_Zg1p_G_Cu_Vi_TV_5ud_A_Pe_Y94o_X_2c54f2ec59.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COC>>(v1);
    }

    // decompiled from Move bytecode v6
}

