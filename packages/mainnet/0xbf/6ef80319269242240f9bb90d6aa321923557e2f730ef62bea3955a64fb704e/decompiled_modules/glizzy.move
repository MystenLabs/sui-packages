module 0xbf6ef80319269242240f9bb90d6aa321923557e2f730ef62bea3955a64fb704e::glizzy {
    struct GLIZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLIZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLIZZY>(arg0, 6, b"GLIZZY", b"Glizzy The Bear", b"Beating up all these fishies on Sui! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_11_at_3_36_21_PM_c0c080b845.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLIZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLIZZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

