module 0xf38955a4e839f94b3f848f94ff24d18df200544f9dd71986854ed31c45f8ac59::https {
    struct HTTPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HTTPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HTTPS>(arg0, 6, b"HTTPS", b"HTTPS SUI", b"Had to Take Profits Sir", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_DM_Bn_Qr_MPLE_Qef_X7_Z7r_B_Ygahi_Yw725_RE_Gm22_Dbo_Kpump_3328a8f156.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HTTPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HTTPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

