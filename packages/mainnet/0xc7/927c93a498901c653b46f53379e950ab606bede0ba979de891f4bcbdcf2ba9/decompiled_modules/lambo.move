module 0xc7927c93a498901c653b46f53379e950ab606bede0ba979de891f4bcbdcf2ba9::lambo {
    struct LAMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMBO>(arg0, 6, b"LAMBO", b"Sui LAmbo", b"drive sui lamboooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_13_19_06_32_A_logo_for_a_meme_coin_character_called_Future_Ape_The_character_is_a_blue_ape_from_the_future_with_a_cyberpunk_aesthetic_The_ape_has_electric_blu_cb2ae8f355.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

