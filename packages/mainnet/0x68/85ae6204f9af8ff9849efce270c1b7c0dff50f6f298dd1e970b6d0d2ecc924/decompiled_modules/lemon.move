module 0x6885ae6204f9af8ff9849efce270c1b7c0dff50f6f298dd1e970b6d0d2ecc924::lemon {
    struct LEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEMON>(arg0, 9, b"Lemon", b"Lemon", b"Life Gave You Lemons, Now Watch Them Moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"onlylemon.sui")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LEMON>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEMON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

