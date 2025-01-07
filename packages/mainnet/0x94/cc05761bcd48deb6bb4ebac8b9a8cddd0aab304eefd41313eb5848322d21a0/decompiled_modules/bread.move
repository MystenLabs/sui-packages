module 0x94cc05761bcd48deb6bb4ebac8b9a8cddd0aab304eefd41313eb5848322d21a0::bread {
    struct BREAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREAD>(arg0, 6, b"BREAD", b"Simply Bread", x"49742069732073696d706c7920612042726561642e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pb6_WYBE_5ag3m5qd_Dn_TL_6_Rw_ULE_48_Aa2w_XF_8_MS_Kh_Ht65hw_4db174056c.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BREAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

