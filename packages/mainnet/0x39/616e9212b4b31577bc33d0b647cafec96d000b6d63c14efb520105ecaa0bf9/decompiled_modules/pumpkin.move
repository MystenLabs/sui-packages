module 0x39616e9212b4b31577bc33d0b647cafec96d000b6d63c14efb520105ecaa0bf9::pumpkin {
    struct PUMPKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPKIN>(arg0, 6, b"PUMPKIN", b"Mr. Pumpkin", b"Ready to pump up your crypto excitement! Inspired by the harvest season, Mr. Pumpkin blends fun with innovation. Join the unique crypto celebration and experience how Mr. Pumpkin brings vibrant energy to the market!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4oo3g_QN_Rb_Lbh_B9c_C8_Yirfmt_Yy_Dv_E_Tw_Uvr_Rt2z6ympump_fa3bada38a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPKIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

