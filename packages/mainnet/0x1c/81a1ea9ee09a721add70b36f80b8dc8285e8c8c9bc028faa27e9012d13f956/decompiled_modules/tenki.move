module 0x1c81a1ea9ee09a721add70b36f80b8dc8285e8c8c9bc028faa27e9012d13f956::tenki {
    struct TENKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TENKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TENKI>(arg0, 6, b"TENKI", b"Tenki", b"Tenki the baby walrus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmag_Zj_MH_4oy_He_Pv_Da_Ev471n3e_Gfcw_Ys_R_Sg_Vb_U4w_Y_Aec_Cy3_11c6eef022.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TENKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TENKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

