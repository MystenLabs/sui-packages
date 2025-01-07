module 0xa9157de67d87cb04190231dbf750d44c3bdb1edf3931816beafb0df0657b499e::sumn {
    struct SUMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMN>(arg0, 6, b"SUMN", b"SUIMOON", b"Blast off to the Moon with SUI  the symbol of rapid growth and limitless potential in the crypto world. Invest in a future that's already taking flight!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLE_2024_10_11_00_07_02_A_super_cartoonish_image_of_a_character_happily_riding_on_a_rocket_labeled_SUI_flying_through_a_colorful_whimsical_space_The_character_should_hav_216d38be69.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

