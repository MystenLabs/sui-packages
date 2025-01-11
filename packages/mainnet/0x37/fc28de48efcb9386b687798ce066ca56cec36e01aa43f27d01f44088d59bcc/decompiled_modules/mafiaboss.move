module 0x37fc28de48efcb9386b687798ce066ca56cec36e01aa43f27d01f44088d59bcc::mafiaboss {
    struct MAFIABOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAFIABOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAFIABOSS>(arg0, 6, b"MAFIABOSS", b"MAFIA BOSS", b"MEMECOIN CREATED TO REPRESENT MAFIA LUXURY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_01_11_16_51_20_A_cartoon_style_image_featuring_the_blue_character_from_the_provided_image_The_character_is_sitting_confidently_in_a_luxurious_private_jet_wearing_s_73f72c64a4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAFIABOSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAFIABOSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

