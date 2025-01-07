module 0x7a9cffb12701473fe1897c1b72c8bc53cd71bd9bb37f07c3cdbad734e9dd70ab::sega {
    struct SEGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEGA>(arg0, 6, b"SEGA", b"SELL GARAGE", b"SELL GARAGE !!!)))", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/T8_Vw_DP_7up_U_teke_Hqj2_e_U_Grz_OU_1920_f96bca8dba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

