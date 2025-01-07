module 0x6392bd8ec62b1513467c3ded3a0a213673ff2be844ca5d2609713d585db81ec6::picasso {
    struct PICASSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PICASSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PICASSO>(arg0, 9, b"PICASSO", x"f09f96bcefb88f5069636173736f", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PICASSO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PICASSO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PICASSO>>(v1);
    }

    // decompiled from Move bytecode v6
}

