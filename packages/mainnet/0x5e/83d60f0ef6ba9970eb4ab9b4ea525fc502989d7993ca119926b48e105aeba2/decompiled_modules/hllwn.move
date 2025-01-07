module 0x5e83d60f0ef6ba9970eb4ab9b4ea525fc502989d7993ca119926b48e105aeba2::hllwn {
    struct HLLWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLLWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HLLWN>(arg0, 6, b"HLLWN", b"Clementine", b"yes my eyes are real", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbe_S5v_Tt_Q_Li_Juq_Y_Ype_S2nx8revkqd_Dnw_Mbv_Bf1te6_W_Suu_468b85334b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HLLWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HLLWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

