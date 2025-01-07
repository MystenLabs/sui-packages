module 0xbd7e00a7a9978fdd1525b3f032b8cbe0d45c6c2fe8ed3b05b2bc39e67b4dbe19::fuckwar {
    struct FUCKWAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKWAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKWAR>(arg0, 6, b"FUCKWAR", b"FUCK WAR !", x"4655434b205741520a4655434b494e472057415220210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ads_Ae_z_tasar_Ae_m_1_2987caff96.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKWAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUCKWAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

