module 0xdd6c8b3d414e0a1bba3b5d77220a31ff47e2e376d587215a01827f91c511278e::lusui {
    struct LUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUSUI>(arg0, 6, b"LUSUI", b"Lusui The Dog", b"Lusui The Dog, The Lady Of Sui! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_03_at_12_26_44_PM_f62343623f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

