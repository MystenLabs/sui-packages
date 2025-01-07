module 0xaf56a765a78ff0e959d1b5fdac26e4f80bf00766cdfd374770052785d6c25643::harati {
    struct HARATI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARATI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARATI>(arg0, 6, b"HARATI", b"Harati", x"48617261746920697320726561647920746f206265636f6d652061206e65772063756c7420636c61737369632e20446f20796f75206d696e64206a6f696e696e672068696d3f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmdy_L3_KN_9m_PTE_Zv_UT_Ln_TK_1j_Kp8g5_PS_Mgj_Fg16_S_Wy51o_Hn_J_72a1e44e31.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARATI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HARATI>>(v1);
    }

    // decompiled from Move bytecode v6
}

