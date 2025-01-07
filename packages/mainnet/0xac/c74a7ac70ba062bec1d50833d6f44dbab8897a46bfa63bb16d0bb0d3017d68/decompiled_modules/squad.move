module 0xacc74a7ac70ba062bec1d50833d6f44dbab8897a46bfa63bb16d0bb0d3017d68::squad {
    struct SQUAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUAD>(arg0, 6, b"Squad", b"Make sui memeable", b"We are a conglomerate of squads that make Sui memeable.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_07_11_45_35_A_playful_meme_style_coin_design_featuring_a_cute_mischievous_raccoon_holding_a_shiny_coin_with_a_paw_print_on_it_The_raccoon_has_wide_eyes_and_a_c_429717a123.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

