module 0xbf9f45c84ee285bcfeee32d11f10f55f4ef170a72b7121b2665d8baec5d8434c::bakso {
    struct BAKSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAKSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAKSO>(arg0, 6, b"Bakso", b"Disney Sumatran Tiger", b"FIRST LOOK  Meet two-week old, Bakso, the newest Sumatran tiger cub at Disneys Animal Kingdom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_YSG_Fb_Z_Yu_B_Ez_Z_Dt3a_G3_K_Gc8_ZR_Gmhph_S_Ync2g4nupb7_VAS_bd538a60e1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAKSO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAKSO>>(v1);
    }

    // decompiled from Move bytecode v6
}

