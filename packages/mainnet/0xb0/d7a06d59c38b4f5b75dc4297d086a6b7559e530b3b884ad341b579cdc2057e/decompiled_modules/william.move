module 0xb0d7a06d59c38b4f5b75dc4297d086a6b7559e530b3b884ad341b579cdc2057e::william {
    struct WILLIAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILLIAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILLIAM>(arg0, 6, b"William", b"magnet dev", b"William Sturgeon magnet dev", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_G5_Q_Gx_Xbr_VZX_9ujv6n_XBR_5_A_Gp_Si_YMFRUK_Kt_Vzcpo17m_D_9969ce6334.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILLIAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILLIAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

