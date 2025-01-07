module 0x56044b6f1d6de615aa5a46d437b67482f13be8e1f7406c0fc4d6367fead78daa::suitanc {
    struct SUITANC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITANC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITANC>(arg0, 6, b"SUITANC", b"SUITANIST", b"Etheism? Suitanism!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_03_00_14_46_A_glowing_blue_pentagram_set_against_a_dark_mysterious_background_The_lines_of_the_pentagram_are_formed_with_bright_electric_blue_light_creating_a_bfd3060d84.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITANC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITANC>>(v1);
    }

    // decompiled from Move bytecode v6
}

