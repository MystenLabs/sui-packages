module 0x546b768e600ae53fc0324c9ebf81bef336b262604f2883015ccd011d18478143::labraorca {
    struct LABRAORCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABRAORCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABRAORCA>(arg0, 6, b"LABRAORCA", b"LABRAORCASUI", b"labrorca", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Imagem_do_Whats_App_de_2024_09_12_A_s_19_36_18_36227964_534cd010c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABRAORCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LABRAORCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

