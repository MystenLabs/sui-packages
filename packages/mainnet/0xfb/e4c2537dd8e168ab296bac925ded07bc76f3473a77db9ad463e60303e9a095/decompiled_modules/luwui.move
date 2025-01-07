module 0xfbe4c2537dd8e168ab296bac925ded07bc76f3473a77db9ad463e60303e9a095::luwui {
    struct LUWUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUWUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUWUI>(arg0, 6, b"LUWUI", b"Luwui The Cat", b"Luwui The Cat Wants To Be The Official Mascot Of Sui! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_03_at_3_24_16_PM_e4271f2e7f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUWUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUWUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

