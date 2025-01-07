module 0x91cc002be44c14674708e066f4cd18e029f84facd79eb9072b5c11f956ef199d::pink {
    struct PINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINK>(arg0, 9, b"PINK", b"PINK", b"Pink Panther is hunting for gems with ai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PINK>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINK>>(v2, @0x2f033a77925dc9cc331b1a3b7f9148eccdaffcef2b086d1ed29517f7d6b1b6c);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

