module 0x2494e9b2862738ef3458aa02d57b34d0bc737ba466895e20edabe475345271d7::duckbuk {
    struct DUCKBUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKBUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKBUK>(arg0, 6, b"DUCKBUK", b"DUCK BUCK", b"The funniest memecoin in the crypto space. With a touch of humor and a vibrant community, $DUCKBUCK is the symbol of dreamers who believe the next \"to the moon\" will be led by a duck. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_01_08_22_12_37_A_cartoon_style_penguin_inspired_by_a_futuristic_agent_design_combining_adorable_rounded_features_with_big_expressive_eyes_wearing_blue_goggles_a_t_6c03bc6b50.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKBUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKBUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

