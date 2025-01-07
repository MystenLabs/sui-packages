module 0xbcd6dd6da6f70f65d292d625a5678b8a5eb44dbe46e418d09fadb1d1dabd02d2::tramp {
    struct TRAMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRAMP>(arg0, 9, b"TRAMP", b"DONALD TRAMP", b"Moon?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRAMP>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRAMP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRAMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

