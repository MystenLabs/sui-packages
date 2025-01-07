module 0xd75f43f1bd8777b61a1abaa4a28c9e80181b9a925cd5108622a0b4e4fa5f3bda::mona_lisa {
    struct MONA_LISA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONA_LISA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONA_LISA>(arg0, 9, b"MONA LISA", x"f09f96bcefb88f4d6f6e61204c697361", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MONA_LISA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONA_LISA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONA_LISA>>(v1);
    }

    // decompiled from Move bytecode v6
}

