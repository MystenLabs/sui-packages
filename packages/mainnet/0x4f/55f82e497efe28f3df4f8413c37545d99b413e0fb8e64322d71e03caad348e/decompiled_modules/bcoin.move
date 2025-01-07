module 0x4f55f82e497efe28f3df4f8413c37545d99b413e0fb8e64322d71e03caad348e::bcoin {
    struct BCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCOIN>(arg0, 6, b"BCOIN", b"BUTTCOIN", b"BUTTCOIN from the creator of FARTCOIN, ASSCOIN, SHITCOIN and more. Thank you Shitoshi. The dev of magical BUTTCOIN lore.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/77_Khqra_Boui_U91_K_Rch_LPY_8_D_Yb_Vtfs_H4n_S_Bg_H_Cd4_U_Aw_BY_7d1434c282.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

