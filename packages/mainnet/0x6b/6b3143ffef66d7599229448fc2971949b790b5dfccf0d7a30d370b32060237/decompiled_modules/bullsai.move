module 0x6b6b3143ffef66d7599229448fc2971949b790b5dfccf0d7a30d370b32060237::bullsai {
    struct BULLSAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLSAI>(arg0, 6, b"BullsAI", b"Bullseye", b"BullseyeSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/giphy_ezgif_com_webp_to_gif_converter_c026dce3f9.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLSAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLSAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

