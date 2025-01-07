module 0xe8c2f1b5c283a60df6a77922fe5c177c42965ec808ca4104889f1166b1058d90::norwiegenteppe {
    struct NORWIEGENTEPPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NORWIEGENTEPPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NORWIEGENTEPPE>(arg0, 6, b"NorwiegenTeppe", b"teppe", b"pepe meme. just a meme coin for fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_19_at_23_13_25_Rugvista_core_Gabbeh_loom_Two_Lines_Gr_A_nn_140_x_200_cm_Ullteppe_Rugvista_916ce4361f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NORWIEGENTEPPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NORWIEGENTEPPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

