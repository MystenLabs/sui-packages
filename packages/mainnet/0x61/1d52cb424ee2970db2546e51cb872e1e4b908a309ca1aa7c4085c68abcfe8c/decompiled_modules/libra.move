module 0x611d52cb424ee2970db2546e51cb872e1e4b908a309ca1aa7c4085c68abcfe8c::libra {
    struct LIBRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIBRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIBRA>(arg0, 9, b"LIBRA", b"Libra", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LIBRA>(&mut v2, 890000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIBRA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIBRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

