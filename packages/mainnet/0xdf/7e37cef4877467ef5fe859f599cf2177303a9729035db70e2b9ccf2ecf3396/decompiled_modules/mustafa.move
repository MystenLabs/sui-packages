module 0xdf7e37cef4877467ef5fe859f599cf2177303a9729035db70e2b9ccf2ecf3396::mustafa {
    struct MUSTAFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSTAFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSTAFA>(arg0, 6, b"MUSTAFA", b"MUSTACHE", b"What?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C4583922_D91_D_425_C_8_BFD_5068521_BB_5_AE_dd12f0d5ba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSTAFA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUSTAFA>>(v1);
    }

    // decompiled from Move bytecode v6
}

