module 0x3313cb3bd449197dd76523bd02ec054616c6e2a5649207853592571008ae11b2::suirocket {
    struct SUIROCKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIROCKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIROCKET>(arg0, 6, b"SUIROCKET", b"THE SUI ROCKET", b"LETS GO TO THE SUIMOON.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/srock_c2106d2d99.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIROCKET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIROCKET>>(v1);
    }

    // decompiled from Move bytecode v6
}

