module 0x2411e7f56d40b5801ff10c74d4b060a5174a4d2e2f31332437979a6c25926d::sboge {
    struct SBOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBOGE>(arg0, 6, b"SBOGE", b"SUI BOGE", x"4d656574202453424f47450a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t_A_N_Uwd_C_400x400_d30316ad51.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

