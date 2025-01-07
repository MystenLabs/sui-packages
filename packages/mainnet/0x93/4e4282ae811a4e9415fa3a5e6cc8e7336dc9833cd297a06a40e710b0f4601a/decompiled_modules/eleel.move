module 0x934e4282ae811a4e9415fa3a5e6cc8e7336dc9833cd297a06a40e710b0f4601a::eleel {
    struct ELEEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELEEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELEEL>(arg0, 6, b"Eleel", b"Sui Eel", b"el' eel enters sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/electric_eel_fish_lively_stay_bank_vector_ai_generated_image_clipart_cartoon_deisgn_icon_324467758_4c70df0288.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELEEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELEEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

