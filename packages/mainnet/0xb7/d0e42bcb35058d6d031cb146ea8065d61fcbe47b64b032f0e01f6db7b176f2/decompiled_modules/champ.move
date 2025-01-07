module 0xb7d0e42bcb35058d6d031cb146ea8065d61fcbe47b64b032f0e01f6db7b176f2::champ {
    struct CHAMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAMP>(arg0, 6, b"CHAMP", b"SUICHAMP", b"SUI Champ is a Degen kid who is exploring SUI to find the right memes to ride along this bull run. 2025 is coming and champ will be unstoppable to become the SUI champion. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_07_11_05_42_A_modern_cartoon_boy_wearing_a_white_cap_with_the_SUI_blockchain_symbol_on_the_front_The_boy_has_a_curious_expression_as_he_explores_variou_f9189fe1eb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

