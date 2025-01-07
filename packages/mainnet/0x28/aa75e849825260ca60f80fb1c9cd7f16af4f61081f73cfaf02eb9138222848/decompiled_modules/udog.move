module 0x28aa75e849825260ca60f80fb1c9cd7f16af4f61081f73cfaf02eb9138222848::udog {
    struct UDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: UDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UDOG>(arg0, 6, b"Udog", b"Ufo DOG", b"Ufo DOG on movepump. Aliens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GU_3kh_YL_Xg_AAE_Vaf_2cac2f7852.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

