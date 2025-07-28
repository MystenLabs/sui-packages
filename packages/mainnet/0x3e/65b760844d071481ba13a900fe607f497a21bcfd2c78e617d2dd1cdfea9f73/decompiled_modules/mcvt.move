module 0x3e65b760844d071481ba13a900fe607f497a21bcfd2c78e617d2dd1cdfea9f73::mcvt {
    struct MCVT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCVT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCVT>(arg0, 6, b"MCVT", b"Mill City Ventures by SUI", b"Finance firm Mill City Ventures to buy $441M in SUI tokens, pivoting to crypto treasury strategy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/p_II_Hp2lu_400x400_5512056564.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCVT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCVT>>(v1);
    }

    // decompiled from Move bytecode v6
}

