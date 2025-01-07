module 0x68acb91bc2817f1f07328d06a3dfa8cffdcdfcffb151eabf6d37d68f4ca7fcd4::teppe {
    struct TEPPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEPPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEPPE>(arg0, 6, b"Teppe", b"norwegian teppe", b"pepe meme. just a meme coin for fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_19_at_23_13_25_Rugvista_core_Gabbeh_loom_Two_Lines_Gr_A_nn_140_x_200_cm_Ullteppe_Rugvista_916ce4361f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEPPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEPPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

