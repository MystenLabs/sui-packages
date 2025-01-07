module 0x2664c36fb606991251d8891afbd4fbedb3b89ea287139eca58ea3a120ec78e4e::yolo {
    struct YOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOLO>(arg0, 6, b"YOLO", b"YOLOSUI", b"Yolo Sui: Where meme magic meets Sui power. Join us on this journey!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_25_23_42_03_A_vibrant_and_eye_catching_profile_picture_designed_for_X_formerly_Twitter_featuring_Yolo_Inu_The_character_a_heroic_Doge_hybrid_stands_confidentl_213a763f6a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

