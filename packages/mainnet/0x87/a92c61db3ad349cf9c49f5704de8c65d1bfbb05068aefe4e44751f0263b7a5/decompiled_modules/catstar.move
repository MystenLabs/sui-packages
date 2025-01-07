module 0x87a92c61db3ad349cf9c49f5704de8c65d1bfbb05068aefe4e44751f0263b7a5::catstar {
    struct CATSTAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSTAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSTAR>(arg0, 6, b"CATSTAR", b"CATS", x"43415453544152206f7572206e6577657374206d656d6520746f6b656e206164732077696c6c20737461727420717569636b6c792c20646f6e2774206d69737320746865206f70706f7274756e6974790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_Wi8_E_Rz_Yo2_Bojv_GL_Pd_A6_Qxm_Exv_Q_Jh_TNC_1h_Zb_Hn_QEM_7_U1_0aacf3e442.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSTAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATSTAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

