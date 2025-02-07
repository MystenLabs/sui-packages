module 0x25b1dba1a46be95a5481a7cd518ca8b0c0a7e3c1a0ec0ecde433f2f26dec2c72::ldos {
    struct LDOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LDOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LDOS>(arg0, 6, b"LDOS", b"Long Doge OS", b"Explore the Long Doge Operating System on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designsanstitre25_ezgif_com_optimize_065d36d302.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LDOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LDOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

