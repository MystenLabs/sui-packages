module 0x109809efbfda0b9d449e5fcf2ce4451a648ca2892c3bd3be8877ab16cf0543da::squidd {
    struct SQUIDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIDD>(arg0, 6, b"SQUIDD", b"squidd game25", b"Squid game 25 is here.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suidog_d5ab119d4e.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

