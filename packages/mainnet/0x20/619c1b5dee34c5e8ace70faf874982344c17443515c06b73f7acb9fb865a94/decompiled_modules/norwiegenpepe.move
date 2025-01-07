module 0x20619c1b5dee34c5e8ace70faf874982344c17443515c06b73f7acb9fb865a94::norwiegenpepe {
    struct NORWIEGENPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NORWIEGENPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NORWIEGENPEPE>(arg0, 6, b"Norwiegenpepe", b"teppe", b"pepe norwiegen teppe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_19_at_23_13_25_Rugvista_core_Gabbeh_loom_Two_Lines_Gr_A_nn_140_x_200_cm_Ullteppe_Rugvista_7450757b18.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NORWIEGENPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NORWIEGENPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

