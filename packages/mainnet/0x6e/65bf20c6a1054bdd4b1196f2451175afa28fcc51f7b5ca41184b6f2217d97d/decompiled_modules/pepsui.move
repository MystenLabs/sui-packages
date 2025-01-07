module 0x6e65bf20c6a1054bdd4b1196f2451175afa28fcc51f7b5ca41184b6f2217d97d::pepsui {
    struct PEPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPSUI>(arg0, 6, b"Pepsui", b"Pepsui Soda", b"Refresh your day with Pepsui! Bold flavor, just the right fizz, and a twist of sweetness that hits the spot every time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_F603_BC_7_8_DED_461_F_9843_7183_CD_0_EEA_6_D_796f64a1d2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

