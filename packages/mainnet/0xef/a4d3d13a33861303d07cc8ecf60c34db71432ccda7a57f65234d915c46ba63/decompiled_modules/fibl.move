module 0xefa4d3d13a33861303d07cc8ecf60c34db71432ccda7a57f65234d915c46ba63::fibl {
    struct FIBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIBL>(arg0, 6, b"FIBL", b"FIBLS", b"Fibl sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1731364551_6052861_3_ED_42301_4_D1_D_4_C45_A7_F2_B43_D69_B1_F389_60fed306ea.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

