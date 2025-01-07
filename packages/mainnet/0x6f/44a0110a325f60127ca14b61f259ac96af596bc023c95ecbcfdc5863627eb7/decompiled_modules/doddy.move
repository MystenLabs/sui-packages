module 0x6f44a0110a325f60127ca14b61f259ac96af596bc023c95ecbcfdc5863627eb7::doddy {
    struct DODDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DODDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DODDY>(arg0, 6, b"DODDY", b"DODDY SUI", b"I'm your daddy, bring me Boden and Tremp. I will let them taste my Doddy oil!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B_Lu_Yi5_Wtw_Ck_AV_Egxw_AL_119_Gwz_F_Hzjq6me3e_WPW_95pump_485065b68d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DODDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DODDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

