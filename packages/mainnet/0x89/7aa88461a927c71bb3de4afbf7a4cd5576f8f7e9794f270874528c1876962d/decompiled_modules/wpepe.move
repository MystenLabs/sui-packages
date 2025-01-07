module 0x897aa88461a927c71bb3de4afbf7a4cd5576f8f7e9794f270874528c1876962d::wpepe {
    struct WPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WPEPE>(arg0, 6, b"WPEPE", b"Wizard Pepe", x"5374657020696e746f20746865206d61676963616c207265616c6d206f6620706570650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Xc_DV_6_Rp88_Hn5mszzui_P9zko_Rn_Gps_P1_L5_Dj7n_Dw_J_Yf2fu_99f95ae3e3.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

