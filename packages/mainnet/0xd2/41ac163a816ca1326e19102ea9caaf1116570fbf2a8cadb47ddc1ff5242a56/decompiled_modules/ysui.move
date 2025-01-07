module 0xd241ac163a816ca1326e19102ea9caaf1116570fbf2a8cadb47ddc1ff5242a56::ysui {
    struct YSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YSUI>(arg0, 6, b"YSUI", b"YOLOSUI", b"Yolo Sui: Where meme magic meets Sui power. Join us on this journey!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_26_00_44_30_Yolo_Sui_a_heroic_Doge_hybrid_character_standing_confidently_and_wearing_a_classic_black_hat_with_the_phrase_Make_America_Great_Again_on_the_front_be16fe5567.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

