module 0x3060fe892ccdcbc366c388679ee76679f2e23ca9ea5c0994d7c0f94c1359ee6a::yolo {
    struct YOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOLO>(arg0, 6, b"YOLO", b"YOLOSUI", b"Yolo Sui: Where meme magic meets Sui power. Join us on this journey!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_26_10_40_39_A_logo_for_Yolo_Sui_featuring_a_bold_futuristic_design_The_logo_combines_elements_of_a_Doge_Shiba_Inu_hybrid_face_and_glowing_Sui_symbols_creating_8ece6e1d01.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

