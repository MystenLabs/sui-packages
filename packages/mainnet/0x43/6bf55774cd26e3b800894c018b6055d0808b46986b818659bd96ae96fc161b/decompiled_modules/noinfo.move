module 0x436bf55774cd26e3b800894c018b6055d0808b46986b818659bd96ae96fc161b::noinfo {
    struct NOINFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOINFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOINFO>(arg0, 6, b"NOINFO", b"NOINFO?", b"?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_08_09_20_45_A_question_mark_designed_to_resemble_a_lifelike_creature_made_of_water_with_a_deep_sea_blue_color_and_realistic_organic_features_It_should_have_dis_26f99769de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOINFO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOINFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

