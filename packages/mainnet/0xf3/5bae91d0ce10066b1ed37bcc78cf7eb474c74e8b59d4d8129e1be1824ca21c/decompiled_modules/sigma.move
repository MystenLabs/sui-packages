module 0xf35bae91d0ce10066b1ed37bcc78cf7eb474c74e8b59d4d8129e1be1824ca21c::sigma {
    struct SIGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIGMA>(arg0, 6, b"SIGMA", b"SIGMA ON SUI", x"5369676d61204d616c6573206f6e205355492e205375636365737366756c20616e6420666f63757365642e2057686572656f74686572206d616c6573206661696c202c20776520737563636565642c2077686572652074686579206a65657420776520627579206d6f72652e20576520617265206275696c7420646966666572656e746c792e204265636f6d652061207369676d6120746f6461790a0a4e6f20736f6369616c206d6564696120616e64206e6f2062756c6c736869740a0a74686973206973207369676d61", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_SVG_3_T9_CN_Qsm2k_Ewzb_Rq6h_A_Sqh1o_Gfjq_Tt_LXY_Uibpump_1_ff52096900.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIGMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIGMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

