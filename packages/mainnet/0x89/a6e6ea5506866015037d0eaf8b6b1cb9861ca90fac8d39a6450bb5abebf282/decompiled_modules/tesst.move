module 0x89a6e6ea5506866015037d0eaf8b6b1cb9861ca90fac8d39a6450bb5abebf282::tesst {
    struct TESST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESST>(arg0, 6, b"TESST", b"TESTSST", b"STE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_R_Zq_UT_5_P_400x400_f35eb54bd8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESST>>(v1);
    }

    // decompiled from Move bytecode v6
}

