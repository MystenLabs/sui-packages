module 0x20f1782e928b921a00cbbbe759d10e136610db555ca0ab16d34e79924a8f1014::toki {
    struct TOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKI>(arg0, 6, b"TOKI", b"Toki the Hippo dog", b"Toki the Hippo dog: Welcome to the world of Toki the Hippo Dog, the internet sensation thats taking TikTok by storm!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_04_at_16_45_57_8e490d1f6c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

