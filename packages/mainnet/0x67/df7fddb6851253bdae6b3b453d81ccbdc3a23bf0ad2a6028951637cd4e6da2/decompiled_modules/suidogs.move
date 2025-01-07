module 0x67df7fddb6851253bdae6b3b453d81ccbdc3a23bf0ad2a6028951637cd4e6da2::suidogs {
    struct SUIDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOGS>(arg0, 6, b"SuiDOGS", b"Sui DOGS", b"WOOF WOOF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ads_Ae_z_tasar_Ae_m_2_Photoroom_png_Photoroom_15aa9b8305.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

