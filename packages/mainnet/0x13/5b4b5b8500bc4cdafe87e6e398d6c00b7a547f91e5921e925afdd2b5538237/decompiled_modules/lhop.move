module 0x135b4b5b8500bc4cdafe87e6e398d6c00b7a547f91e5921e925afdd2b5538237::lhop {
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

