module 0x3fbf86a6e911eb8a0109f0382316314accd364443eefc3fb7dea9ec406fa3228::bcgu {
    struct BCGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCGU>(arg0, 6, b"BCGU", b"Baluin Cat Go Up!", b"Baluin Cat Go Up! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_09_at_10_47_15_AM_54ad947672.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BCGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

