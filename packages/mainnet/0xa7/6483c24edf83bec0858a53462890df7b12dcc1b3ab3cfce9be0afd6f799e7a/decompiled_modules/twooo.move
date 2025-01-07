module 0xa76483c24edf83bec0858a53462890df7b12dcc1b3ab3cfce9be0afd6f799e7a::twooo {
    struct TWOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWOOO>(arg0, 6, b"TWOOO", b"twooo man", b"2 is the new 4 ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GY_0av7_WW_8_A_Ma_I_Oz_606c4ca360.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWOOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWOOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

