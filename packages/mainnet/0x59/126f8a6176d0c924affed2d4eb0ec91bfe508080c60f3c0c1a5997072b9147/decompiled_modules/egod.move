module 0x59126f8a6176d0c924affed2d4eb0ec91bfe508080c60f3c0c1a5997072b9147::egod {
    struct EGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGOD>(arg0, 6, b"EGOD", b"EGOD ENAN", b"Dog binance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Wd_Mo_B_Xw_A_Afo_Rn_1_f057624eac.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

