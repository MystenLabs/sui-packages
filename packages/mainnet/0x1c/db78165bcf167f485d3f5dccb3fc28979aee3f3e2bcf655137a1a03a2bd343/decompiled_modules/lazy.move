module 0x1cdb78165bcf167f485d3f5dccb3fc28979aee3f3e2bcf655137a1a03a2bd343::lazy {
    struct LAZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAZY>(arg0, 6, b"LAZY", b"LAZY on sui", b"tooo lazy to do something", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_18_14_15_06_A_cartoon_style_character_resembling_a_blue_humanoid_rabbit_with_long_ears_and_a_laid_back_or_tired_expression_The_character_is_drawn_in_a_simple_hu_799623dee0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

