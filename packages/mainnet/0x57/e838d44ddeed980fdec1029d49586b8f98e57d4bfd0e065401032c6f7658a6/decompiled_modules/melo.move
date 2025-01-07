module 0x57e838d44ddeed980fdec1029d49586b8f98e57d4bfd0e065401032c6f7658a6::melo {
    struct MELO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELO>(arg0, 6, b"MELO", b"CARAMELO DOG", b"Caramelo Dog is a memecoin inspired by the \"caramelo\" dog, a symbol of Brazilian street culture. It reflects the Brazilian spirit, with direct references to the country in its name and aesthetic. The coin aims to build an engaged community, celebrating Brazil's unique culture and humor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_PR_Ug6_F_Khx7udsw_LN_6a_X_Vo_Zk_Mh_Y_Pig_W_Gvys_Rj_Yt175m_Q2_7174b3e540.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MELO>>(v1);
    }

    // decompiled from Move bytecode v6
}

