module 0x7354e0910d33722384acf824f8384ae18d14b90e758ae74d4f8a2558c92d44fa::lhop {
    struct LHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LHOP>(arg0, 6, b"LHOP", b"LOADHOP", b"LOAD LOAD LOAD... HOP HOP HOP ... BZZZZZ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capture_da_e_I_cran_2024_11_03_a_I_02_20_17_78140fbab2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LHOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

