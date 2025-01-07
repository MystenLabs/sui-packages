module 0x743d187f42dcd52601be80d44846e6914d88d46bff4c1ab601a56e201f64a69e::mui {
    struct MUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUI>(arg0, 6, b"MUI", b"Mui", b"The Newest Pokemon, Sui Front-runs Nintendo!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_03_at_5_06_46_PM_1_2588c33a08.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

